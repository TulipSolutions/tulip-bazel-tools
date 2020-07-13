# Rules addlicense

Bazel rules for applying Google's [addlicense](https://github.com/google/addlicense), design inspired by
[Buildifier](https://github.com/bazelbuild/buildtools/tree/master/buildifier).

## Setup and usage

Import this repository (common for all rules, see [parent directory README.md](../README.md)).

As addlicense is a Golang project, you may need to add the following to your `WORKSPACE`.

    load("@nl_tulipsolutions_bazel_tools//:go-deps.bzl", "tulip_bazel_tools_go_dependencies")

    tulip_bazel_tools_go_dependencies()

    load("@nl_tulipsolutions_bazel_tools//:go-setup.bzl", "tulip_bazel_tools_go_setup")

    tulip_bazel_tools_go_setup()

Add the following code to the `WORKSPACE` file for addlicense itself.

    load("@nl_tulipsolutions_bazel_tools//rules_addlicense:deps.bzl", "addlicense_dependencies")

    addlicense_dependencies()

The following statements placed in a `BUILD` file will verify the addlicense rules against all known files recursively.

    load("@nl_tulipsolutions_bazel_tools//rules_addlicense:def.bzl", "addlicense")

    addlicense(
        name = "addlicense_format",
    )

    addlicense(
        name = "addlicense_check",
        mode = "check",
    )
