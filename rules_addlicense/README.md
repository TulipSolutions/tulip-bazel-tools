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
        copyright_holder = "My Organization",
    )

    addlicense(
        name = "addlicense_check",
        copyright_holder = "My Organization",
        mode = "check",
    )

## Optional arguments

### Path

The `path` argument selects a directory relative to the workspace root as base for running the formatter on.
If not provided, this is the root of the workspace.

### License type

By default, addlicense applies the Apache open source license.
Other licenses can be used instead by supplying the `license_type` parameter.
Available options: `apache`, `bsd`, `mit`.

Example:

    addlicense(
        name = "addlicense_format",
        copyright_holder = "My Organization",
        license_type = "bsd",
    )

*A custom license file header is not yet supported in these Bazel rules (PR is welcome).*

### Exclude patterns

The `exclude_patterns` argument allows for a list of glob patterns to exclude matching files for the rule.
If omitted, the built-in default list of glob patterns is `[".*.git/*", ".*.project/*", ".*idea/*"]`.
You may want to include them again when supplying your own set, e.g.:

    addlicense(
        name = "addlicense_format",
        exclude_patterns = [
           ".*.git/*",
           ".*.project/*",
           ".*idea/*",
           "*node_modules*",
           "./package-lock.json",
           "./.ijwb/*",
        ],
    )

## Limitations

### Shell argument length limit

Under the hood, a `find` command gathers all files to select for formatting based on the exclude patterns and path.
These will be provided as arguments to the actual formatter binary.
If the number of files (arguments) or the total length of it exceed the maximum for the Bash shell, the command may fail
with an error `Argument list too long`.
Use appropriate `exclude_patterns` and/or `path` arguments to select files in your project more selectively.

Please keep in mind to re-include the defaults of `exclude_patterns` when specifying your own.

A pull request to rework the logic in the runner, by batching over a certain amount of files at a time would be welcome.
