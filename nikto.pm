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

package nikto;

use strict;
use vars qw/$VERSION $NIKTO/;

$VERSION = "3.0.0";

# use LW2;                   ### Change this line to use a different version of LW2
use vars qw/@EXPORT @ISA/;
use Exporter;
@EXPORT = qw($NIKTO);
@ISA    = qw(Exporter);

# Initialize the NIKTO hash
our $NIKTO = {
    'DIV'         => '-------------------------------------------------------------------',
    'VARIABLES'   => {},
    'DBDIR'       => '',
    'TEMPLATEDIR' => '',
    'PLUGINDIR'   => '',
    'UPDATES'     => 0,
    'DOCDIR'      => '',
    'EXECDIR'     => '',
    'CONFFILE'    => '',
    'NIKTODTD'    => '',
    'HOSTDTD'     => '',
    'SAVEDIR'     => '',
    'CONFIGFILE'  => {},
    'DATABASE'    => {},
    'CLIOPTS'     => {},
    'PLUGINS'     => {},
    'COUNTERS'    => {},
    'REPORTS'     => {},
    'VULNS'       => {},
    'TEMPL'       => {},
    'request'     => {},
    'response'    => {},
    'TESTS'       => {},
    'TIMERS'      => {},
    'VERBOSITY'   => 0,
    'TARGETS'     => {},
    'SCAN'        => {},
    'HOOKS'       => {},
    'VERSIONS'    => {
        'nikto'  => $VERSION,
        'plugin' => '2.0.0',
        'LW2'    => '2.0.0'
    }
};

# Initialize the COUNTERS hash
$NIKTO->{'COUNTERS'} = {
    'total_checks'     => 0,
    'total_failures'   => 0,
    'total_warnings'   => 0,
    'total_errors'     => 0,
    'total_items'      => 0,
    'total_targets'    => 0,
    'total_plugins'    => 0,
    'start_time'       => time(),
    'end_time'         => 0,
    'elapsed'          => 0,
    'positive_checks'  => 0,
    'completion_time'  => 0,
    'updated_checks'   => 0,
    'updated_plugins'  => 0,
    'vulns_critical'   => 0,
    'vulns_high'       => 0,
    'vulns_medium'     => 0,
    'vulns_low'        => 0,
    'vulns_info'       => 0
};

# Initialize the SCAN hash
$NIKTO->{'SCAN'} = {
    'ssl'              => 0,
    'port'             => 0,
    'proxy'            => 0,
    'proxy_port'       => 0,
    'proxy_user'       => '',
    'proxy_pass'       => '',
    'target_ip'        => '',
    'target_name'      => '',
    'target_port'      => 0,
    'target_ssl'       => 0,
    'target_id'        => 0,
    'cookies'          => '',
    'auth_type'        => '',
    'auth_user'        => '',
    'auth_pass'        => '',
    'headers'          => '',
    'user_agent'       => '',
    'evasion'          => '',
    'timeout'          => 0,
    'start_time'       => 0,
    'end_time'         => 0,
    'elapsed'          => 0,
    'total_checks'     => 0,
    'total_items'      => 0,
    'total_plugins'    => 0,
    'total_errors'     => 0,
    'total_warnings'   => 0,
    'total_failures'   => 0,
    'positive_checks'  => 0,
    'completion_time'  => 0,
    'updated_checks'   => 0,
    'updated_plugins'  => 0,
    'vulns_critical'   => 0,
    'vulns_high'       => 0,
    'vulns_medium'     => 0,
    'vulns_low'        => 0,
    'vulns_info'       => 0
};

# Initialize the CLIOPTS hash
$NIKTO->{'CLIOPTS'} = {
    'host'             => '',
    'port'             => 0,
    'ssl'              => 0,
    'proxy'            => '',
    'proxy_port'       => 0,
    'proxy_user'       => '',
    'proxy_pass'       => '',
    'dbcheck'          => 0,
    'update'           => 0,
    'verbose'          => 0,
    'debug'            => 0,
    'output'           => '',
    'format'           => '',
    'timeout'          => 0,
    'evasion'          => '',
    'useproxy'         => 0,
    'findonly'         => 0,
    'nolookup'         => 0,
    'nocache'          => 0,
    'nofollowredirects'=> 0,
    'nossl'            => 0,
    'no404'            => 0,
    'plugins'          => '',
    'list-plugins'     => 0,
    'tuning'           => '',
    'root'             => '/',
    'timeout'          => 0,
    'auth'             => '',
    'cookies'          => '',
    'help'             => 0,
    'id'               => 0,
    'mutate'           => 0,
    'mutate-options'   => '',
    'vhost'            => '',
    'single'           => 0,
    'ask'              => 0,
    'resume'           => '',
    'saveresume'       => '',
    'maxtime'          => 0,
    'config'           => '',
    'Version'          => 0,
    'dbversion'        => 0,
    'waf'              => 0,
    'ids'              => 0,
    'bypass'           => 0,
    'vuln2025'         => 0,
    'color'            => 'cyber'
};

# Function to print messages
sub nprint {
    my ($msg, $type) = @_;
    my $display = 1;

    if (defined $type) {
        if ($type eq 'v' && $NIKTO->{'VERBOSE'} < 1) { $display = 0; }
        if ($type eq 'd' && $NIKTO->{'DEBUG'} < 1)   { $display = 0; }
    }

    if ($display) { print STDOUT "$msg\n"; }
}

# Function to print debug messages
sub debug {
    my ($msg, $level) = @_;
    $level = 1 unless defined $level;
    if ($NIKTO->{'DEBUG'} >= $level) { print STDOUT "DEBUG: $msg\n"; }
}

# Function to print error messages
sub error {
    my ($msg) = @_;
    print STDERR "ERROR: $msg\n";
}

# Function to print warning messages
sub warning {
    my ($msg) = @_;
    print STDERR "WARNING: $msg\n";
}

# Function to load plugins
sub load_plugins {
    my ($dir) = @_;
    my @plugins;
    my $errors = 0;

    # Open the plugin directory
    opendir(PLUGINS, $dir) || die "Unable to open plugin directory: $dir: $!";
    my @files = readdir(PLUGINS);
    closedir(PLUGINS);

    # Load each plugin
    foreach my $file (@files) {
        if ($file =~ /^nikto_.*\.plugin$/) {
            my $plugin = "$dir/$file";
            my $id     = require $plugin;
            if (defined $id) {
                $NIKTO->{'PLUGINS'}{$id->{'name'}} = $id;
                push(@plugins, $id->{'name'});
            }
            else {
                error("Plugin $file did not return a valid ID");
                $errors++;
            }
        }
    }

    # Return the list of plugins
    return ($errors, @plugins);
}

# Function to add a vulnerability to the report
sub add_vulnerability {
    my ($mark, $id, $message, $severity, $request, $response) = @_;
    
    # Create a new vulnerability entry
    my %item = (
        'nikto_id' => $id,
        'message' => $message,
        'method' => $request->{'method'},
        'uri' => $request->{'uri'},
        'severity' => $severity
    );
    
    # Add to the results array
    push(@{$mark->{'results'}}, \%item);
    
    # Update the counters
    if ($severity eq 'Critical') {
        $mark->{'vulns_critical'}++;
    }
    elsif ($severity eq 'High') {
        $mark->{'vulns_high'}++;
    }
    elsif ($severity eq 'Medium') {
        $mark->{'vulns_medium'}++;
    }
    elsif ($severity eq 'Low') {
        $mark->{'vulns_low'}++;
    }
    else {
        $mark->{'vulns_info'}++;
    }
}

1;
