# Rules Ktlint

Bazel rules for applying [Ktlint](https://github.com/pinterest/ktlint), design inspired by [Buildifier](https://github.com/bazelbuild/buildtools/tree/master/buildifier).
Ktlint is a linter and formatter for Kotlin.

## Setup and usage

Import this repository (common for all rules, see [parent directory README.md](../README.md)).

Add the following code to the `WORKSPACE` file

    load("@nl_tulipsolutions_bazel_tools//rules_ktlint:deps.bzl", "ktlint_dependencies")

    ktlint_dependencies()

The following statements placed in a `BUILD` file will verify the Ktlint rules against all `.kt` and `.kts` in a directory recursively.

    load("@nl_tulipsolutions_bazel_tools//rules_ktlint:def.bzl", "ktlint")

    ktlint(
        name = "ktlint_format",
        format = True,
    )

    ktlint(
        name = "ktlint_check",
    )

Ktlint allows some (limited) additional configuration using a [`editorconfig`](https://editorconfig.org/) file placed in the root of the project.
