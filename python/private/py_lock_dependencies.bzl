# Copyright 2024 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"Rule for locking third-party dependencies."

def _py_lock_dependencies(ctx):
    uv = ctx.toolchains["//python/private/uv:toolchain_type"].uv
    args = ctx.actions.args()
    args.add("pip")
    args.add("compile")
    args.add("--python-platform", "windows")
    args.add("--python-version", "3.9")
    args.add("--no-strip-extras")
    args.add("--generate-hashes")
    requirements_out = ctx.actions.declare_file(ctx.label.name + ".requirements.out")
    args.add("--output-file", requirements_out)
    args.add(ctx.file.dependencies_file)

    ctx.actions.run(
        executable = uv.files_to_run,
        arguments = [args],
        inputs = [ctx.file.dependencies_file],
        outputs = [requirements_out],
    )

    return [DefaultInfo(
        files = depset([requirements_out]),
    )]

py_lock_dependencies = rule(
    implementation = _py_lock_dependencies,
    attrs = {
        "constraints_file": attr.label(allow_single_file = True),
        "dependencies_file": attr.label(allow_single_file = True),
        "overrides_file": attr.label(allow_single_file = True),
    },
    toolchains = [
        "//python/private/uv:toolchain_type",
    ],
)
