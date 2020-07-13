load("@bazel_skylib//lib:shell.bzl", "shell")

def _ktlint_impl(ctx):
    args = [
        "--verbose=%s" % str(ctx.attr.verbose).lower(),
        "--format=%s" % str(ctx.attr.format).lower(),
        "--relative=%s" % str(ctx.attr.relative).lower(),
    ]

    include_patterns = ctx.attr.include_patterns + ["!bazel-*/**", "!.git/**"]

    out_file = ctx.actions.declare_file(ctx.label.name + ".bash")
    substitutions = {
        "@@ARGS@@": shell.array_literal(args),
        "@@KTLINT_SHORT_PATH@@": shell.quote(ctx.executable._ktlint.short_path),
        "@@INCLUDE_PATTERNS@@": shell.array_literal(include_patterns),
    }

    ctx.actions.expand_template(
        template = ctx.file._runner,
        output = out_file,
        substitutions = substitutions,
        is_executable = True,
    )
    runfiles = ctx.runfiles(files = [ctx.executable._ktlint])
    return [DefaultInfo(
        runfiles = runfiles,
        executable = out_file,
    )]

ktlint = rule(
    implementation = _ktlint_impl,
    attrs = {
        "verbose": attr.bool(
            doc = "Print verbose information on standard error",
            default = False,
        ),
        "format": attr.bool(
            doc = "Formats the code",
            default = False,
        ),
        "relative": attr.bool(
            doc = "Print files relative to the working directory (e.g. dir/file.kt instead of /home/user/project/dir/file.kt)",
            default = True,
        ),
        "include_patterns": attr.string_list(
            default = ["**/*.kt", "**/*.kts"],  # Check all kotlin files in sub directories of project
            doc = "List of patterns to check or exclude, example: ['src/**/*.kt', '!src/**/*Test.kt']",
        ),
        "_ktlint": attr.label(
            default = Label("@com_github_ktlint//file"),
            cfg = "host",
            allow_single_file = True,
            executable = True,
        ),
        "_runner": attr.label(
            default = Label("//rules_ktlint:runner.bash.template"),
            allow_single_file = True,
        ),
    },
    executable = True,
)
