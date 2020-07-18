load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_skylib//lib:shell.bzl", "shell")

def _intellij_formatter_impl(ctx):
    out_file = ctx.actions.declare_file(ctx.label.name + ".bash")

    intellij_short_path = ""
    for file in ctx.attr._intellij.files.to_list():
        if file.basename == "format.sh":
            intellij_short_path = file.short_path

    if ctx.attr.path:
        format_path = ctx.attr.path
    else:
        format_path = paths.dirname(ctx.build_file_path)
    format_path = paths.join(".", format_path)

    exclude_patterns_str = ""
    if ctx.attr.exclude_patterns:
        exclude_patterns = ["-not -path %s" % shell.quote(pattern) for pattern in ctx.attr.exclude_patterns]
        exclude_patterns_str = " ".join(exclude_patterns) + " -and"

    substitutions = {
        "@@CODE_SCHEME_PATH@@": shell.quote(ctx.file.code_scheme.short_path),
        "@@MODE@@": shell.quote(ctx.attr.mode),
        "@@FORMAT_PATH@@": shell.quote(format_path),
        "@@INTELLIJ_SHORT_PATH@@": shell.quote(intellij_short_path),
        "@@EXCLUDE_PATTERNS@@": exclude_patterns_str,
    }

    ctx.actions.expand_template(
        template = ctx.file._runner,
        output = out_file,
        substitutions = substitutions,
        is_executable = True,
    )
    runfiles = ctx.runfiles(files = ctx.attr._intellij.files.to_list() + [ctx.file.code_scheme])
    return [DefaultInfo(
        runfiles = runfiles,
        executable = out_file,
    )]

intellij_formatter = rule(
    implementation = _intellij_formatter_impl,
    attrs = {
        "mode": attr.string(
            values = [
                "format",
                "check",
            ],
            default = "format",
        ),
        "exclude_patterns": attr.string_list(
            allow_empty = True,
            doc = "A list of glob patterns passed to the find command. E.g. './vendor/*' to exclude the Go vendor directory",
            default = [
                ".*.git/*",
                ".*.project/*",
                ".*idea/*",
            ],
        ),
        "path": attr.string(
            doc = "Relative path from workspace root",
        ),
        "code_scheme": attr.label(
            default = Label("//rules_intellij_formatter:tulip-code-scheme.xml"),
            allow_single_file = True,
        ),
        "_intellij": attr.label(
            default = Label("@nl_tulipsolutions_intellij//:files"),
            allow_files = True,
        ),
        "_runner": attr.label(
            default = Label("//rules_intellij_formatter:runner.bash.template"),
            allow_single_file = True,
        ),
    },
    executable = True,
)
