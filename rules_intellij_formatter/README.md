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

## Optional arguments

### Path

The `path` argument selects a directory relative to the workspace root as base for running the formatter on.
If not provided, this is the root of the workspace.

### Exclude files

The `exclude_patterns` argument allows for a list of glob patterns to exclude matching files for the rule.
If omitted, the built-in default list of glob patterns is `[".*.git/*", ".*.project/*", ".*idea/*"]`.
You may want to include them again when supplying your own set, e.g.:

    intellij_formatter(
        name = "intellij_format",
        exclude_patterns = [
           ".*.git/*",
           ".*.project/*",
           ".*idea/*",
           "*node_modules*",
           "./package-lock.json",
           "./.ijwb/*",
        ],
    )

### Custom code schema file (XML)

The built-in default is the bundled Tulipsolutions code schema XML file.

IntelliJ IDEA allows to export your own code scheme from the menu:
*Settings*, *Editor*, *Code Style*, *wrench icon*, *Export*, *IntelliJ IDEA Code style XML*.

Then override the default using the `code_scheme` argument pointing to the XML file label.
Example for placing in your project in `mypkg/mydir/mycodescheme.xml`:

    intellij_formatter(
        name = "intellij_format",
        code_scheme = "//mypkg/mydir:mycodescheme.xml",
    )

And, in `mypkg/mydir/BUILD.bazel`, this file should be marked as exportable for use, e.g.:

    exports_files(["mycodescheme.xml"])

## Limitations

### Shell argument length limit

Under the hood, a `find` command gathers all files to select for formatting based on the exclude patterns and path.
These will be provided as arguments to the actual formatter binary.
If the number of files (arguments) or the total length of it exceed the maximum for the Bash shell, the command may fail
with an error `Argument list too long`.
Use appropriate `exclude_patterns` and/or `path` arguments to select files in your project more selectively.

Please keep in mind to re-include the defaults of `exclude_patterns` when specifying your own.

A pull request to rework the logic in the runner, by batching over a certain amount of files at a time would be welcome.
