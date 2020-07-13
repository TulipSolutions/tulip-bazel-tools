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
        add_license_version = "22550fa7c1b07a27e810565721ac49469615e05b"

        go_repository(
            name = "com_github_google_addlicense",
            importpath = "github.com/google/addlicense",
            sha256 = "beeea8a9e2950a23b0bb1e22d94cd58bea9cfaf1d321ef9f2ac2707d92ce7ab3",
            strip_prefix = "addlicense-%s" % add_license_version,
            urls = ["https://github.com/google/addlicense/archive/%s.zip" % add_license_version],
        )
