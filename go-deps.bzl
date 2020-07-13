load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def tulip_bazel_tools_go_dependencies(
        omit_io_bazel_rules_go_version = False,
        omit_bazel_gazelle = False,
        omit_io_bazel_rules_closure = False,
        omit_com_google_protobuf = False):
    if not omit_io_bazel_rules_go_version and not native.existing_rule("io_bazel_rules_go"):
        io_bazel_rules_go_version = "v0.21.2"

        http_archive(
            name = "io_bazel_rules_go",
            urls = [
                "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/{v}/rules_go-{v}.tar.gz".format(v = io_bazel_rules_go_version),
                "https://github.com/bazelbuild/rules_go/releases/download/{v}/rules_go-{v}.tar.gz".format(v = io_bazel_rules_go_version),
            ],
            sha256 = "f99a9d76e972e0c8f935b2fe6d0d9d778f67c760c6d2400e23fc2e469016e2bd",
        )

    if not omit_bazel_gazelle and not native.existing_rule("bazel_gazelle"):
        bazel_gazelle_version = "v0.20.0"

        http_archive(
            name = "bazel_gazelle",
            urls = [
                "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/bazel-gazelle/releases/download/{v}/bazel-gazelle-{v}.tar.gz".format(v = bazel_gazelle_version),
                "https://github.com/bazelbuild/bazel-gazelle/releases/download/{v}/bazel-gazelle-{v}.tar.gz".format(v = bazel_gazelle_version),
            ],
            sha256 = "d8c45ee70ec39a57e7a05e5027c32b1576cc7f16d9dd37135b0eddde45cf1b10",
        )

    if not omit_io_bazel_rules_closure and not native.existing_rule("io_bazel_rules_closure"):
        io_bazel_rules_closure_version = "614e1ebc38249c6793eab2e078bceb0fb12a1a42"  # master HEAD on 2020-01-28

        http_archive(
            name = "io_bazel_rules_closure",
            sha256 = "d214736912d20293395682d7142411a117f0a17fb4d7e205ccbd438bd4a3738d",
            strip_prefix = "rules_closure-%s" % io_bazel_rules_closure_version,
            urls = ["https://github.com/bazelbuild/rules_closure/archive/%s.zip" % io_bazel_rules_closure_version],
        )

    if not omit_com_google_protobuf and not native.existing_rule("com_google_protobuf"):
        protobuf_version = "v3.11.3"

        http_archive(
            name = "com_google_protobuf",
            patches = [
                # Get rid of the annoying build warnings by opting out for Java 7 compatibility:
                # warning: -parameters is not supported for target value 1.7. Use 1.8 or later.
                "@io_bazel_rules_closure//closure:protobuf_drop_java_7_compatibility.patch",
            ],
            patch_args = ["-p1"],
            sha256 = "832c476bb442ca98a59c2291b8a504648d1c139b74acc15ef667a0e8f5e984e7",
            strip_prefix = "protobuf-%s" % protobuf_version[1:],
            urls = ["https://github.com/google/protobuf/archive/%s.zip" % protobuf_version],
        )
