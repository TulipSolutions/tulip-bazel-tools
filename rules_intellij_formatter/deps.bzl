load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

intellij_idea_build_file_contents = """
filegroup(
    name = "files",
    srcs = glob([
        "bin/**/*",
        "lib/**/*",
        "plugins/**/*",
        "system/**/*",
        "build.txt",
    ]),
    visibility = ["//visibility:public"],
)
"""

def intellij_formatter_dependencies(
        omit_bazel_skylib = False,
        omit_nl_tulipsolutions_intellij = False):
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

    if not omit_nl_tulipsolutions_intellij and not native.existing_rule("nl_tulipsolutions_intellij"):
        intellij_version = "201.8538.31"

        http_archive(
            name = "nl_tulipsolutions_intellij",
            build_file_content = intellij_idea_build_file_contents,
            patches = [
                "@nl_tulipsolutions_bazel_tools//third_party/patches/org_jetbrains_idea:intellij-ic-idea.properties-temp-config.patch",
            ],
            strip_prefix = "idea-IC-%s" % intellij_version,
            sha256 = "0a80edad0e774b363db622c11e6a4e7d1ad1ac59293c8176115026b39a88743f",
            urls = ["https://download.jetbrains.com/idea/ideaIC-2020.1.3-no-jbr.tar.gz"],
        )
