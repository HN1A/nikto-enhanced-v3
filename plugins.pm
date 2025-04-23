###############################################################################
#  Copyright (C) 2025 Enhanced Nikto Project
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; version 2
#  of the License only.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
###############################################################################

package plugins;

use strict;
use vars qw/$VERSION/;

$VERSION = "3.0.0";

use vars qw/@EXPORT @ISA/;
use Exporter;
@EXPORT = qw(%PLUGINDB);
@ISA    = qw(Exporter);

# Plugin database
our %PLUGINDB;

# Function to load a plugin
sub load_plugin {
    my ($file, $dir) = @_;
    my $id;
    
    # Check if the file exists
    if (!-f "$dir/$file") {
        nikto::nprint("Plugin file not found: $dir/$file", "d");
        return undef;
    }
    
    # Load the plugin
    $id = require "$dir/$file";
    
    # Check if the plugin returned a valid ID
    if (!defined $id) {
        nikto::nprint("Plugin $file did not return a valid ID", "d");
        return undef;
    }
    
    # Check if the ID is a hash reference
    if (ref($id) ne 'HASH') {
        nikto::nprint("Plugin $file returned an ID that is not a hash reference", "d");
        return undef;
    }
    
    # Add the plugin to the database
    $PLUGINDB{$id->{'name'}} = $id;
    
    return $id;
}

# Function to load all plugins in a directory
sub load_plugins {
    my ($dir) = @_;
    my @plugins;
    my $errors = 0;
    
    # Check if the directory exists
    if (!-d $dir) {
        nikto::nprint("Plugin directory not found: $dir", "d");
        return (1, ());
    }
    
    # Open the plugin directory
    opendir(PLUGINS, $dir) || die "Unable to open plugin directory: $dir: $!";
    my @files = readdir(PLUGINS);
    closedir(PLUGINS);
    
    # Load each plugin
    foreach my $file (@files) {
        if ($file =~ /^nikto_.*\.plugin$/) {
            my $id = load_plugin($file, $dir);
            if (defined $id && ref($id) eq 'HASH') {
                push(@plugins, $id->{'name'});
            }
            else {
                $errors++;
            }
        }
    }
    
    # Return the list of plugins
    return ($errors, @plugins);
}

# Function to get a plugin by name
sub get_plugin {
    my ($name) = @_;
    
    # Check if the plugin exists
    if (!exists $PLUGINDB{$name}) {
        nikto::nprint("Plugin not found: $name", "d");
        return undef;
    }
    
    return $PLUGINDB{$name};
}

# Function to get all plugins
sub get_plugins {
    return %PLUGINDB;
}

# Function to call a plugin hook
sub call_hook {
    my ($hook, $mark) = @_;
    
    # Check if the hook exists
    if (!exists $mark->{'hooks'} || !defined $mark->{'hooks'}) {
        return $mark;
    }
    
    if (!exists $mark->{'hooks'}->{$hook} || !defined $mark->{'hooks'}->{$hook}) {
        return $mark;
    }
    
    # Call the hook
    my $function = $mark->{'hooks'}->{$hook};
    if (defined $function && ref($function) eq 'CODE') {
        return &$function($mark);
    }
    else {
        nikto::nprint("Hook $hook is not a code reference", "d");
        return $mark;
    }
}

1;
