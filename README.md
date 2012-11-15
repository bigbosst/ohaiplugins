ohaiplugins
===========

My personal repository for some Ohai Plugins for Chef.

First plugin is for Linux systems and will register all PCI devices. Useful for derterminaning the hardware running on a system for installing RAID controllers or other drivers. This plugin is dependent on LSPCI (will not run without it)

Installation
===========
Recomended Installation with the ohai chef community cookbook

### Example Install with Cookbook

place this and any other plugins in an 'ohai_plugins' folder in the files/default/ path insid of 'yourawesomecookbook'

	node.set['ohai']['plugins']  = {'yourawesomecookbook' => 'ohai_plugins'}
	include_recipe "ohai::default"


Usage
===========
The script pushes an array of individual pci devevices into pci->devices. Each devices is represented by a hash, including fields like devicename, vendor, and type.

### Example usage of Ohai data from the PCI plugin
	if (node[:pci][:devices].detect {|d| d['vendor'].include? "3ware"} )
		#Install 3ware Raid driver
	end
