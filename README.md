# Tulip Bazel Build Tools collection

This repository contains a few Bazel rules. See the sections below for each set of rules.

## Common project setup (`WORKSPACE`)

Put this in your project's `WORKSPACE`:

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "nl_tulipsolutions_bazel_tools",
    strip_prefix = "tulip-bazel-tools-master",
    url = "https://github.com/TulipSolutions/tulip-bazel-tools/archive/master.zip",
)
```

## IntelliJ IDEA formatter

This downloads IntelliJ IDEA Community edition and runs the headless formatter.

Please see [rules_intellij_formatter/README.md](rules_intellij_formatter/README.md).

## Kotlin linter: ktlint

Project page: [ktlint](https://github.com/pinterest/ktlint).

Please see [rules_ktlint/README.md](rules_ktlint/README.md).

## Ensure file header license: addlicense

Google's [addlicense](https://github.com/google/addlicense) is a tool to ensure a license is present on all files in the
header.

Please see [rules_addlicense/README.md](rules_addlicense/README.md).
