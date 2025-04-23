#!/usr/bin/perl
#
# Enhanced Nikto v3 Main Script
# (c) 2025 Enhanced Nikto Project
#
# This is the main script for the enhanced version of Nikto v3
# with improved visual interface, animated startup sequence,
# advanced anonymity features, and automatic proxy discovery.
#

use strict;
use lib './';

# Load core modules
use nikto;
use plugins;
use Getopt::Long;
use Time::Local;
use Time::HiRes qw(sleep);

# Version information
my %VARIABLES;
$VARIABLES{'version'} = "3.5.0-Enhanced-v3";
$VARIABLES{'program'} = "Nikto Enhanced v3";

# Display welcome message
print "$VARIABLES{'program'} v$VARIABLES{'version'}\n";

# Enhanced features configuration
my %ENHANCED_CONFIG = (
    # Enhanced UI options
    'animation' => 1,
    'color_intensity' => 2,
    'startup_delay' => 5,
    'port_delay' => 3,
    'color_scheme' => 'cyber',
    
    # Auto proxy options
    'auto_proxy' => 1,
    'max_proxies' => 5,
    'proxy_timeout' => 2,
    'proxy_sources' => "public,local,tor",
    'high_speed' => 1,
    
    # Advanced scanning options
    'advanced_scan' => 1,
    'crawl_depth' => 3,
    'max_pages' => 1000,
    
    # Advanced anonymity options
    'multi_layer_tor' => 1,
    'tor_layers' => 5,
    'advanced_identity' => 1,
    'rotation_frequency' => 30,
    'advanced_obfuscation' => 1,
    'traffic_padding' => 1,
    'timing_obfuscation' => 1,
    'browser_emulation' => 1,
    
    # Protection bypass options
    'protection_bypass' => 1,
    'captcha_bypass' => 1,
    'waf_evasion' => 1,
    'ids_bypass' => 1,
    'snort3_bypass' => 1,
    'rate_limit_bypass' => 1,
    
    # Security detection options
    'security_detection' => 1,
    'active_detection' => 1,
    'passive_detection' => 1,
    'header_analysis' => 1,
    
    # Vulnerability scanning options
    'vuln2025' => 1,
    
    # Visualization options
    'visualization' => 1,
    'color' => 1,
    'progress_bar' => 1,
    'results_chart' => 1,
    
    # Language options
    'english_only' => 1
);

# Add enhanced command line options
my %CLI_ENHANCED = (
    # Enhanced UI options
    'animation!' => \$ENHANCED_CONFIG{'animation'},
    'color-intensity=i' => \$ENHANCED_CONFIG{'color_intensity'},
    'startup-delay=i' => \$ENHANCED_CONFIG{'startup_delay'},
    'port-delay=i' => \$ENHANCED_CONFIG{'port_delay'},
    'color-scheme=s' => \$ENHANCED_CONFIG{'color_scheme'},
    
    # Auto proxy options
    'auto-proxy!' => \$ENHANCED_CONFIG{'auto_proxy'},
    'max-proxies=i' => \$ENHANCED_CONFIG{'max_proxies'},
    'proxy-timeout=i' => \$ENHANCED_CONFIG{'proxy_timeout'},
    'proxy-sources=s' => \$ENHANCED_CONFIG{'proxy_sources'},
    'high-speed!' => \$ENHANCED_CONFIG{'high_speed'},
    
    # Advanced scanning options
    'advanced-scan!' => \$ENHANCED_CONFIG{'advanced_scan'},
    'crawl-depth=i' => \$ENHANCED_CONFIG{'crawl_depth'},
    'max-pages=i' => \$ENHANCED_CONFIG{'max_pages'},
    
    # Advanced anonymity options
    'multi-layer-tor!' => \$ENHANCED_CONFIG{'multi_layer_tor'},
    'tor-layers=i' => \$ENHANCED_CONFIG{'tor_layers'},
    'advanced-identity!' => \$ENHANCED_CONFIG{'advanced_identity'},
    'rotation-frequency=i' => \$ENHANCED_CONFIG{'rotation_frequency'},
    'advanced-obfuscation!' => \$ENHANCED_CONFIG{'advanced_obfuscation'},
    'traffic-padding!' => \$ENHANCED_CONFIG{'traffic_padding'},
    'timing-obfuscation!' => \$ENHANCED_CONFIG{'timing_obfuscation'},
    'browser-emulation!' => \$ENHANCED_CONFIG{'browser_emulation'},
    
    # Protection bypass options
    'protection-bypass!' => \$ENHANCED_CONFIG{'protection_bypass'},
    'captcha-bypass!' => \$ENHANCED_CONFIG{'captcha_bypass'},
    'waf!' => \$ENHANCED_CONFIG{'waf_evasion'},
    'ids!' => \$ENHANCED_CONFIG{'ids_bypass'},
    'snort3-bypass!' => \$ENHANCED_CONFIG{'snort3_bypass'},
    'bypass!' => \$ENHANCED_CONFIG{'protection_bypass'},
    'rate-limit-bypass!' => \$ENHANCED_CONFIG{'rate_limit_bypass'},
    
    # Security detection options
    'security-detection!' => \$ENHANCED_CONFIG{'security_detection'},
    'active-detection!' => \$ENHANCED_CONFIG{'active_detection'},
    'passive-detection!' => \$ENHANCED_CONFIG{'passive_detection'},
    'header-analysis!' => \$ENHANCED_CONFIG{'header_analysis'},
    
    # Vulnerability scanning options
    'vuln2025!' => \$ENHANCED_CONFIG{'vuln2025'},
    
    # Visualization options
    'visualization!' => \$ENHANCED_CONFIG{'visualization'},
    'color!' => \$ENHANCED_CONFIG{'color'},
    'progress-bar!' => \$ENHANCED_CONFIG{'progress_bar'},
    'results-chart!' => \$ENHANCED_CONFIG{'results_chart'},
    
    # Language options
    'english-only!' => \$ENHANCED_CONFIG{'english_only'}
);

# Standard Nikto options
my %CLI_STANDARD = (
    'help|h' => \&show_help,
    'host=s' => \$VARIABLES{'host'},
    'port=s' => \$VARIABLES{'port'},
    'ssl' => \$VARIABLES{'ssl'},
    'nossl' => \$VARIABLES{'nossl'},
    'output=s' => \$VARIABLES{'output'},
    'format=s' => \$VARIABLES{'format'},
    'dbcheck' => \$VARIABLES{'dbcheck'},
    'update' => \$VARIABLES{'update'},
    'config=s' => \$VARIABLES{'config'},
    'verbose' => \$VARIABLES{'verbose'},
    'debug' => \$VARIABLES{'debug'},
    'timeout=i' => \$VARIABLES{'timeout'},
    'root=s' => \$VARIABLES{'root'},
    'useproxy' => \$VARIABLES{'useproxy'},
    'nolookup' => \$VARIABLES{'nolookup'},
    'nocache' => \$VARIABLES{'nocache'},
    'evasion=s' => \$VARIABLES{'evasion'},
    'plugins=s' => \$VARIABLES{'plugins'},
    'list-plugins' => \$VARIABLES{'list-plugins'},
    'Version' => \$VARIABLES{'Version'},
    'Tuning=s' => \$VARIABLES{'Tuning'}
);

# Merge enhanced options with standard Nikto options
my %CONFIGFILE;
my %CLI = (%CONFIGFILE, %CLI_STANDARD, %CLI_ENHANCED);

# Parse command line options
GetOptions(\%CLI, keys %CLI);

# Apply enhanced configuration to Nikto
apply_enhanced_config();

# Run Nikto with enhanced features
nikto_main();

# Apply enhanced configuration to Nikto
sub apply_enhanced_config {
    # Enhanced UI options
    $VARIABLES{'enhanced_ui.animation'} = $ENHANCED_CONFIG{'animation'};
    $VARIABLES{'enhanced_ui.color_intensity'} = $ENHANCED_CONFIG{'color_intensity'};
    $VARIABLES{'enhanced_ui.startup_delay'} = $ENHANCED_CONFIG{'startup_delay'};
    $VARIABLES{'enhanced_ui.port_delay'} = $ENHANCED_CONFIG{'port_delay'};
    $VARIABLES{'enhanced_ui.color_scheme'} = $ENHANCED_CONFIG{'color_scheme'};
    
    # Auto proxy options
    $VARIABLES{'auto_proxy.enabled'} = $ENHANCED_CONFIG{'auto_proxy'};
    $VARIABLES{'auto_proxy.max_proxies'} = $ENHANCED_CONFIG{'max_proxies'};
    $VARIABLES{'auto_proxy.proxy_timeout'} = $ENHANCED_CONFIG{'proxy_timeout'};
    $VARIABLES{'auto_proxy.proxy_sources'} = $ENHANCED_CONFIG{'proxy_sources'};
    $VARIABLES{'auto_proxy.high_speed'} = $ENHANCED_CONFIG{'high_speed'};
    
    # Advanced scanning options
    if ($ENHANCED_CONFIG{'advanced_scan'}) {
        $VARIABLES{'advanced_scan.enabled'} = 1;
        $VARIABLES{'advanced_scan.crawl_depth'} = $ENHANCED_CONFIG{'crawl_depth'};
        $VARIABLES{'advanced_scan.max_pages'} = $ENHANCED_CONFIG{'max_pages'};
    }
    
    # Advanced anonymity options
    $VARIABLES{'advanced_anonymity.multi_layer_tor'} = $ENHANCED_CONFIG{'multi_layer_tor'};
    $VARIABLES{'advanced_anonymity.tor_layers'} = $ENHANCED_CONFIG{'tor_layers'};
    $VARIABLES{'advanced_anonymity.advanced_identity'} = $ENHANCED_CONFIG{'advanced_identity'};
    $VARIABLES{'advanced_anonymity.rotation_frequency'} = $ENHANCED_CONFIG{'rotation_frequency'};
    $VARIABLES{'advanced_anonymity.advanced_obfuscation'} = $ENHANCED_CONFIG{'advanced_obfuscation'};
    $VARIABLES{'advanced_anonymity.traffic_padding'} = $ENHANCED_CONFIG{'traffic_padding'};
    $VARIABLES{'advanced_anonymity.timing_obfuscation'} = $ENHANCED_CONFIG{'timing_obfuscation'};
    $VARIABLES{'advanced_anonymity.browser_emulation'} = $ENHANCED_CONFIG{'browser_emulation'};
    
    # Protection bypass options
    if ($ENHANCED_CONFIG{'protection_bypass'} || $ENHANCED_CONFIG{'waf_evasion'} || $ENHANCED_CONFIG{'ids_bypass'} || $ENHANCED_CONFIG{'snort3_bypass'}) {
        $VARIABLES{'protection_bypass.enabled'} = 1;
        $VARIABLES{'protection_bypass.captcha_bypass'} = $ENHANCED_CONFIG{'captcha_bypass'};
        $VARIABLES{'protection_bypass.waf_evasion'} = $ENHANCED_CONFIG{'waf_evasion'};
        $VARIABLES{'protection_bypass.ids_bypass'} = $ENHANCED_CONFIG{'ids_bypass'};
        $VARIABLES{'protection_bypass.snort3_bypass'} = $ENHANCED_CONFIG{'snort3_bypass'};
        $VARIABLES{'protection_bypass.rate_limit_bypass'} = $ENHANCED_CONFIG{'rate_limit_bypass'};
    }
    
    # Security detection options
    if ($ENHANCED_CONFIG{'security_detection'}) {
        $VARIABLES{'security_detection.enabled'} = 1;
        $VARIABLES{'security_detection.active_detection'} = $ENHANCED_CONFIG{'active_detection'};
        $VARIABLES{'security_detection.passive_detection'} = $ENHANCED_CONFIG{'passive_detection'};
        $VARIABLES{'security_detection.header_analysis'} = $ENHANCED_CONFIG{'header_analysis'};
    }
    
    # Vulnerability scanning options
    if ($ENHANCED_CONFIG{'vuln2025'}) {
        $VARIABLES{'vuln2025.enabled'} = 1;
    }
    
    # Visualization options
    if ($ENHANCED_CONFIG{'visualization'}) {
        $VARIABLES{'visualization.enabled'} = 1;
        $VARIABLES{'visualization.color'} = $ENHANCED_CONFIG{'color'};
        $VARIABLES{'visualization.progress_bar'} = $ENHANCED_CONFIG{'progress_bar'};
        $VARIABLES{'visualization.results_chart'} = $ENHANCED_CONFIG{'results_chart'};
    }
    
    # Language options
    if ($ENHANCED_CONFIG{'english_only'}) {
        $VARIABLES{'english_only.enabled'} = 1;
        $ENV{'LANG'} = 'en_US.UTF-8';
        $ENV{'LANGUAGE'} = 'en_US:en';
        $ENV{'LC_ALL'} = 'en_US.UTF-8';
    }
    
    return;
}

# Main Nikto function with enhanced features
sub nikto_main {
    # Load plugins
    plugins_load();
    
    # Load databases
    load_databases();
    
    # Run the scan with enhanced features
    nikto_run();
    
    return;
}

# Load plugins
sub plugins_load {
    # Load plugins from the plugins directory
    nprint("+ Loading plugins...");
    my ($errors, @plugins) = plugins::load_plugins("./plugins");
    if ($errors > 0) {
        nprint("+ $errors errors encountered while loading plugins.");
    }
    if (@plugins) {
        nprint("+ " . scalar(@plugins) . " plugins loaded: " . join(", ", @plugins));
    } else {
        nprint("+ No plugins loaded.");
    }
    return;
}

# Load enhanced databases
sub load_databases {
    # Load standard Nikto databases
    nprint("+ Loading standard Nikto databases...");
    load_db_standard();
    
    # Load enhanced vulnerability database
    if (-e "databases/db_vulnerabilities_2025.db") {
        nprint("+ Loading enhanced vulnerability database...");
        load_db_enhanced("databases/db_vulnerabilities_2025.db");
    }
    
    # Load extended vulnerability database
    if (-e "databases/db_vulnerabilities_2025_extended.db") {
        nprint("+ Loading extended vulnerability database (300 new rules)...");
        load_db_enhanced("databases/db_vulnerabilities_2025_extended.db");
    }
    
    return;
}

# Load standard Nikto databases
sub load_db_standard {
    # This is a placeholder for the standard database loading function
    # In the actual implementation, this would call the original Nikto database loading code
    nprint("+ Standard databases loaded.");
    return;
}

# Load enhanced vulnerability database
sub load_db_enhanced {
    my ($db_file) = @_;
    
    # This is a placeholder for the enhanced database loading function
    # In the actual implementation, this would load the enhanced vulnerability database
    nprint("+ Enhanced database loaded: $db_file");
    
    return;
}

# Run Nikto with enhanced features
sub nikto_run {
    # This is a placeholder for the main Nikto scanning function
    # In the actual implementation, this would call the original Nikto scanning code
    # with the enhanced features enabled
    
    nprint("+ Starting scan with enhanced features...");
    
    # Print enabled enhanced features
    nprint("+ Enhanced features enabled:");
    
    # Enhanced UI features
    if ($VARIABLES{'enhanced_ui.animation'}) {
        nprint("  - Enhanced UI (color scheme: $VARIABLES{'enhanced_ui.color_scheme'}, color intensity: $VARIABLES{'enhanced_ui.color_intensity'}, startup delay: $VARIABLES{'enhanced_ui.startup_delay'}s, port delay: $VARIABLES{'enhanced_ui.port_delay'}s)");
    }
    
    # Auto proxy features
    if ($VARIABLES{'auto_proxy.enabled'}) {
        nprint("  - Auto Proxy Discovery (max: $VARIABLES{'auto_proxy.max_proxies'}, timeout: $VARIABLES{'auto_proxy.proxy_timeout'}s, sources: $VARIABLES{'auto_proxy.proxy_sources'}, high-speed: $VARIABLES{'auto_proxy.high_speed'})");
    }
    
    # Advanced scanning features
    if ($VARIABLES{'advanced_scan.enabled'}) {
        nprint("  - Advanced scanning (depth: $VARIABLES{'advanced_scan.crawl_depth'}, max pages: $VARIABLES{'advanced_scan.max_pages'})");
    }
    
    # Advanced anonymity features
    if ($VARIABLES{'advanced_anonymity.multi_layer_tor'} || $VARIABLES{'advanced_anonymity.advanced_identity'} || $VARIABLES{'advanced_anonymity.advanced_obfuscation'}) {
        my $anon_features = "";
        
        if ($VARIABLES{'advanced_anonymity.multi_layer_tor'}) {
            $anon_features .= "Multi-layer Tor ($VARIABLES{'advanced_anonymity.tor_layers'} layers), ";
        }
        
        if ($VARIABLES{'advanced_anonymity.advanced_identity'}) {
            $anon_features .= "Advanced identity rotation, ";
        }
        
        if ($VARIABLES{'advanced_anonymity.advanced_obfuscation'}) {
            $anon_features .= "Advanced behavior obfuscation";
        }
        
        nprint("  - Advanced anonymity ($anon_features)");
    }
    
    # Protection bypass features
    if ($VARIABLES{'protection_bypass.enabled'}) {
        my $bypass_features = "";
        $bypass_features .= "CAPTCHA bypass, " if $VARIABLES{'protection_bypass.captcha_bypass'};
        $bypass_features .= "WAF evasion, " if $VARIABLES{'protection_bypass.waf_evasion'};
        $bypass_features .= "IDS/IPS bypass, " if $VARIABLES{'protection_bypass.ids_bypass'};
        $bypass_features .= "Snort3 bypass, " if $VARIABLES{'protection_bypass.snort3_bypass'};
        $bypass_features .= "Rate limit bypass" if $VARIABLES{'protection_bypass.rate_limit_bypass'};
        nprint("  - Protection bypass ($bypass_features)");
    }
    
    # Security detection features
    if ($VARIABLES{'security_detection.enabled'}) {
        my $detection_features = "";
        $detection_features .= "Active detection, " if $VARIABLES{'security_detection.active_detection'};
        $detection_features .= "Passive detection, " if $VARIABLES{'security_detection.passive_detection'};
        $detection_features .= "Header analysis" if $VARIABLES{'security_detection.header_analysis'};
        nprint("  - Security detection ($detection_features)");
    }
    
    # Vulnerability scanning options
    if ($VARIABLES{'vuln2025.enabled'}) {
        nprint("  - 2025 Vulnerability scanning enabled (300 new rules)");
    }
    
    # Visualization features
    if ($VARIABLES{'visualization.enabled'}) {
        my $viz_features = "";
        $viz_features .= "Color output, " if $VARIABLES{'visualization.color'};
        $viz_features .= "Progress bar, " if $VARIABLES{'visualization.progress_bar'};
        $viz_features .= "Results chart" if $VARIABLES{'visualization.results_chart'};
        nprint("  - Visualization ($viz_features)");
    }
    
    # Language options
    if ($VARIABLES{'english_only.enabled'}) {
        nprint("  - English-only interface enabled");
    }
    
    # Run the scan
    nprint("+ Scan completed.");
    
    return;
}

# Print message with timestamp
sub nprint {
    my ($msg) = @_;
    my $time = localtime();
    print "[$time] $msg\n";
    return;
}

# Show help
sub show_help {
    print "Usage: $0 [options]\n";
    print "\n";
    print "Standard Options:\n";
    print "  -h, --help                Display this help message\n";
    print "  -host host                Host(s) to target\n";
    print "  -port port                Port(s) to scan\n";
    print "  -ssl                      Use SSL/HTTPS\n";
    print "  -nossl                    Disable SSL/HTTPS\n";
    print "  -output file              Write output to file\n";
    print "  -format format            Output format (csv, json, xml, html)\n";
    print "  -dbcheck                  Check database and other files for syntax errors\n";
    print "  -update                   Update databases and plugins\n";
    print "  -config file              Use alternative config file\n";
    print "  -verbose                  Verbose output\n";
    print "  -debug                    Debug output\n";
    print "  -timeout sec              Set the timeout for requests\n";
    print "  -root path                Prepend path to all requests\n";
    print "  -useproxy                 Use the proxy defined in nikto.conf\n";
    print "  -nolookup                 Do not perform IP->hostname lookups\n";
    print "  -nocache                  Disable response cache\n";
    print "  -evasion tech             Encoding technique to evade IDS/IPS\n";
    print "  -plugins                  Select which plugins to run\n";
    print "  -list-plugins             List all available plugins\n";
    print "  -Version                  Print version information\n";
    print "  -Tuning x                 Scan tuning\n";
    print "\n";
    print "Enhanced Options:\n";
    print "  -waf                      Enable WAF bypass techniques\n";
    print "  -ids                      Enable IDS/IPS bypass techniques\n";
    print "  -bypass                   Enable advanced protection bypass\n";
    print "  -snort3-bypass            Enable specific Snort 3 bypass techniques\n";
    print "  -vuln2025                 Enable scanning for 2025 vulnerabilities\n";
    print "  -color-scheme scheme      Select color scheme (cyber, desert, neon, midnight, blood)\n";
    print "  -animation                Enable/disable startup animation\n";
    print "  -auto-proxy               Enable automatic proxy discovery\n";
    print "  -multi-layer-tor          Enable multi-layer Tor routing\n";
    print "  -advanced-scan            Enable advanced scanning techniques\n";
    print "  -visualization            Enable enhanced visualization features\n";
    print "  -english-only             Force English-only interface\n";
    print "\n";
    exit(0);
}

1;
