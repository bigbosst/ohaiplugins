ohaiplugins
===========

My personal repository for some Ohai Plugins for Chef.

First plugin is for Linux systems and will register all PCI devices. Useful for determining the hardware running on a system for installing RAID controllers or other drivers. This plugin is dependent on LSPCI (will not run without it)

Second plugin lists all installed packages on a system. Currently only works for Debian based systems but will be
expanded to include other distros.

Installation
===========
Recommended Installation with the ohai chef community cookbook

### Example Install with Cookbook

place this and any other plugins in an 'ohai_plugins' folder in the files/default/ path inside of 'yourawesomecookbook'

        node.set['ohai']['plugins']  = {'yourawesomecookbook' => 'ohai_plugins'}
        include_recipe "ohai::default"


Usage
===========
## PCI

The plugin loads all pci devices into pci_devices. Each devices represented by a hash, including fields like devicename, vendor, and type.

#### Example usage
        if (node[:pci_devices].detect {|d| d['vendor'].include? "3ware"} )
                #Install 3ware Raid driver
        end

## Packages

The plugin loads a list of every package currently installed in the system. It could be expanded to include packages in other states. Each entry includes the Version, Architecture, and description.
