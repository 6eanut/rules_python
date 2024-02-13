# Copyright 2023 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""This module is used to construct the config settings in the BUILD file in this same package.
"""

load("//python/private:config_settings.bzl", _VERSION_FLAG_VALUES = "VERSION_FLAG_VALUES", _is_python_config_setting = "is_python_config_setting")

VERSION_FLAG_VALUES = _VERSION_FLAG_VALUES
is_python_config_setting = _is_python_config_setting
