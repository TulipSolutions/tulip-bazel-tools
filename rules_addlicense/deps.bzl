load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_gazelle//:deps.bzl", "go_repository")

def addlicense_dependencies(
        omit_bazel_skylib = False,
        omit_com_github_google_addlicense = False):
    if not omit_bazel_skylib and not native.existing_rule("bazel_skylib"):
        bazel_skylib_version = "1.0.2"

        http_archive(
            name = "bazel_skylib",
            urls = [
                "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{v}/bazel-skylib-{v}.tar.gz".format(v = bazel_skylib_version),
                "https://github.com/bazelbuild/bazel-skylib/releases/download/{v}/bazel-skylib-{v}.tar.gz".format(v = bazel_skylib_version),
            ],
            sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
        )

    if not omit_com_github_google_addlicense and not native.existing_rule("com_github_google_addlicense"):
        addlicense_version = "df58acafd6d50899389e66702729341491643f43"

        go_repository(
            name = "com_github_google_addlicense",
            importpath = "github.com/google/addlicense",
            sha256 = "160ed9e63fbdb435bd73f671f0838098a2967fd7ffb4b137cf88ba1321c11990",
            strip_prefix = "addlicense-%s" % addlicense_version,
            urls = ["https://github.com/google/addlicense/archive/%s.zip" % addlicense_version],
        )
