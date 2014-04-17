#
# Author:: Troy Germain (<troy.germain@gmail.com>)
# Copyright:: Copyright (c) 2012
# License:: Apache License, Version 2.0
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
#

provides "packages"

require_plugin "platform"

packages Mash.new

installed=Array.new

case platform_family
when 'debian'
  re=Regexp.new("^ii*")
  devices=Array.new
  `/usr/bin/dpkg -l`.each_line do |line|
    data=re.match(line)
    if data then
	  stat, pn, ver, arch, *desc = line.split
	  package_output = packages[pn] = { "version" => ver, "architecture"=> arch, "description" => desc.join(" ") }
    end
  end
  eval(package_output)
else
  Ohai::Log.debug("Skipping Packages, cannot find package listing")
end
