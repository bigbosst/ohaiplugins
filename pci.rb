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

provides "pci_devices"

pci_devices Mash.new

# PCI ID / TYPE / VENDOR / DEVICE NAME / -rREVISION / SUBVENDOR / SUBSYSTEM NAME
re=Regexp.new("(.*) \"(.*)\" \"(.*)\" \"(.*)\" -r(.*) \"(.*)\" \"(.*)\"")

devices=Array.new

if File.exists?("/usr/bin/lspci")
  `/usr/bin/lspci -m`.each_line do |line|
    data=re.match(line)
    if data then
	  output = pci_devices[data[1]] = { "devicename" => data[4], "type" => data[2], "subsystem" => data[7], "vendor" => data[3], "subvendor" => data[6], "revision" => data[5] }
	end
  end
  eval(output)
else
  Ohai::Log.debug("Skipping PCI, cannot find /usr/bin/lspci")
end
