load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def ktlint_dependencies(
        omit_bazel_skylib = False,
        omit_com_github_ktlint = False):
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

    if not omit_com_github_ktlint and not native.existing_rule("com_github_ktlint"):
        ktlint_version = "0.34.2"

        http_file(
            name = "com_github_ktlint",
            urls = ["https://github.com/shyiko/ktlint/releases/download/%s/ktlint" % ktlint_version],
            sha256 = "62f1123496548dbc5407da594823b475352043b49d29a925445ae8a690273aec",
        )
