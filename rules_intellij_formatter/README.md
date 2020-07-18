# Rules IntelliJ
Bazel rules for using the IntelliJ IDEA built-in formatter.

## Setup and usage

Import this repository (common for all rules, see [parent directory README.md](../README.md)).

Add the following code to the `WORKSPACE` file

    load("@nl_tulipsolutions_bazel_tools//rules_intellij_formatter:deps.bzl", "intellij_formatter_dependencies")

    intellij_formatter_dependencies()

The following statements placed in a `BUILD` file format all Java, Kotlin, XML, JSON and YAML files in the directory
of the `BUILD` file recursively.

    load("@nl_tulipsolutions_bazel_tools//rules_intellij_formatter:def.bzl", "intellij_formatter")

    intellij_formatter(
        name = "intellij_format",
    )

    # mode=check; relying on git-worktree, operates on a temorary copy of current HEAD tree and displays diff.
    intellij_formatter(
        name = "intellij_check",
        mode = "check",
    )

It's important to enable the `experimental_inprocess_symlink_creation` Bazel flag, as the IntelliJ IDEA Community
tarball contains files with spaces. Set up a `.bazelrc` in your project like this:

    # See also https://github.com/bazelbuild/bazel/issues/4327
    build --experimental_inprocess_symlink_creation
