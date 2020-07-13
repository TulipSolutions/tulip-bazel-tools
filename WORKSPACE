workspace(name = "nl_tulipsolutions_bazel_tools")

load("//rules_intellij_formatter:deps.bzl", "intellij_formatter_dependencies")

intellij_formatter_dependencies()

load("//rules_ktlint:deps.bzl", "ktlint_dependencies")

ktlint_dependencies()

# Go dependencies and setup required for addlicense.

load("//:go-deps.bzl", "tulip_bazel_tools_go_dependencies")

tulip_bazel_tools_go_dependencies()

load("//:go-setup.bzl", "tulip_bazel_tools_go_setup")

tulip_bazel_tools_go_setup()

load("//rules_addlicense:deps.bzl", "addlicense_dependencies")

addlicense_dependencies()
