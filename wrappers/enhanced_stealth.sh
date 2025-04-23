#!/bin/bash
# Enhanced Stealth Module for Nikto
# (c) 2025 Enhanced Nikto Project
#
# This script provides advanced stealth capabilities for Nikto
# including traffic obfuscation, identity hiding, and anti-forensics features

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
RESET='\033[0m'

# Color schemes
declare -A CYBER_SCHEME
CYBER_SCHEME[header]='\033[38;5;39m'
CYBER_SCHEME[info]='\033[38;5;45m'
CYBER_SCHEME[success]='\033[38;5;46m'
CYBER_SCHEME[warning]='\033[38;5;208m'
CYBER_SCHEME[error]='\033[38;5;196m'
CYBER_SCHEME[highlight]='\033[38;5;51m'
CYBER_SCHEME[normal]='\033[38;5;15m'

declare -A DESERT_SCHEME
DESERT_SCHEME[header]='\033[38;5;172m'
DESERT_SCHEME[info]='\033[38;5;180m'
DESERT_SCHEME[success]='\033[38;5;107m'
DESERT_SCHEME[warning]='\033[38;5;214m'
DESERT_SCHEME[error]='\033[38;5;160m'
DESERT_SCHEME[highlight]='\033[38;5;220m'
DESERT_SCHEME[normal]='\033[38;5;223m'

declare -A NEON_SCHEME
NEON_SCHEME[header]='\033[38;5;201m'
NEON_SCHEME[info]='\033[38;5;207m'
NEON_SCHEME[success]='\033[38;5;118m'
NEON_SCHEME[warning]='\033[38;5;226m'
NEON_SCHEME[error]='\033[38;5;197m'
NEON_SCHEME[highlight]='\033[38;5;213m'
NEON_SCHEME[normal]='\033[38;5;159m'

# Default settings
COLOR_SCHEME="CYBER_SCHEME"
VERBOSE=false
TOR_ENABLED=false
RANDOM_MAC=false
DNS_RANDOMIZATION=false
TRAFFIC_PADDING=false
TIMING_RANDOMIZATION=false
LOG_CLEANING=false
MEMORY_CLEANING=false
PROXY_CHAINS=false
PROXY_CHAIN_LENGTH=3
USER_AGENT_ROTATION=true
OUTPUT_FILE=""
TARGET=""
SCAN_TYPE="stealth"
THREADS=5
TIMEOUT=10
DELAY=0
CUSTOM_HEADERS=""
CUSTOM_COOKIES=""
CUSTOM_PAYLOADS=""
CUSTOM_PATHS=""

# Function to print colored messages
print_colored() {
    local message="$1"
    local color_type="$2"
    
    if [[ -z "$color_type" ]]; then
        color_type="normal"
    fi
    
    local scheme_var="${COLOR_SCHEME}[$color_type]"
    local color="${!scheme_var}"
    
    echo -e "${color}${message}${RESET}"
}

# Function to display banner
display_banner() {
    clear
    print_colored "╔════════════════════════════════════════════════════════════╗" "header"
    print_colored "║                                                            ║" "header"
    print_colored "║  Enhanced Stealth Module for Nikto v3.5.0-Enhanced-v3      ║" "header"
    print_colored "║  (c) 2025 Enhanced Nikto Project                           ║" "header"
    print_colored "║                                                            ║" "header"
    print_colored "║  Advanced stealth capabilities for security assessments     ║" "header"
    print_colored "║                                                            ║" "header"
    print_colored "╚════════════════════════════════════════════════════════════╝" "header"
    echo ""
}

# Function to display help
display_help() {
    print_colored "Usage: $0 [options]" "info"
    echo ""
    print_colored "Options:" "info"
    echo "  -t, --target TARGET       Target URL to scan"
    echo "  -o, --output FILE         Output file for results"
    echo "  -c, --color-scheme SCHEME Color scheme to use (cyber, desert, neon)"
    echo "  -T, --threads NUM         Number of threads to use (default: 5)"
    echo "  -d, --delay NUM           Delay between requests in seconds (default: 0)"
    echo "  -s, --scan-type TYPE      Scan type (stealth, aggressive, passive)"
    echo "  --tor                     Enable Tor for anonymity"
    echo "  --random-mac              Enable random MAC address spoofing"
    echo "  --dns-randomization       Enable DNS query randomization"
    echo "  --traffic-padding         Enable traffic padding"
    echo "  --timing-randomization    Enable timing randomization"
    echo "  --log-cleaning            Enable log cleaning"
    echo "  --memory-cleaning         Enable memory cleaning"
    echo "  --proxy-chains            Enable proxy chains"
    echo "  --proxy-chain-length NUM  Number of proxies in chain (default: 3)"
    echo "  --user-agent-rotation     Enable user agent rotation"
    echo "  --custom-headers FILE     File containing custom headers"
    echo "  --custom-cookies FILE     File containing custom cookies"
    echo "  --custom-payloads FILE    File containing custom payloads"
    echo "  --custom-paths FILE       File containing custom paths"
    echo "  -v, --verbose             Enable verbose output"
    echo "  -h, --help                Display this help message"
    echo ""
    print_colored "Examples:" "info"
    echo "  $0 --target https://example.com --tor --random-mac --verbose"
    echo "  $0 -t https://example.com -o results.txt --proxy-chains --timing-randomization"
    echo ""
}

# Function to parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -t|--target)
                TARGET="$2"
                shift 2
                ;;
            -o|--output)
                OUTPUT_FILE="$2"
                shift 2
                ;;
            -c|--color-scheme)
                case "$2" in
                    cyber)
                        COLOR_SCHEME="CYBER_SCHEME"
                        ;;
                    desert)
                        COLOR_SCHEME="DESERT_SCHEME"
                        ;;
                    neon)
                        COLOR_SCHEME="NEON_SCHEME"
                        ;;
                    *)
                        print_colored "Invalid color scheme: $2. Using default." "warning"
                        COLOR_SCHEME="CYBER_SCHEME"
                        ;;
                esac
                shift 2
                ;;
            -T|--threads)
                THREADS="$2"
                shift 2
                ;;
            -d|--delay)
                DELAY="$2"
                shift 2
                ;;
            -s|--scan-type)
                SCAN_TYPE="$2"
                shift 2
                ;;
            --tor)
                TOR_ENABLED=true
                shift
                ;;
            --random-mac)
                RANDOM_MAC=true
                shift
                ;;
            --dns-randomization)
                DNS_RANDOMIZATION=true
                shift
                ;;
            --traffic-padding)
                TRAFFIC_PADDING=true
                shift
                ;;
            --timing-randomization)
                TIMING_RANDOMIZATION=true
                shift
                ;;
            --log-cleaning)
                LOG_CLEANING=true
                shift
                ;;
            --memory-cleaning)
                MEMORY_CLEANING=true
                shift
                ;;
            --proxy-chains)
                PROXY_CHAINS=true
                shift
                ;;
            --proxy-chain-length)
                PROXY_CHAIN_LENGTH="$2"
                shift 2
                ;;
            --user-agent-rotation)
                USER_AGENT_ROTATION=true
                shift
                ;;
            --custom-headers)
                CUSTOM_HEADERS="$2"
                shift 2
                ;;
            --custom-cookies)
                CUSTOM_COOKIES="$2"
                shift 2
                ;;
            --custom-payloads)
                CUSTOM_PAYLOADS="$2"
                shift 2
                ;;
            --custom-paths)
                CUSTOM_PATHS="$2"
                shift 2
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                display_banner
                display_help
                exit 0
                ;;
            *)
                print_colored "Unknown option: $1" "error"
                display_help
                exit 1
                ;;
        esac
    done
    
    # Check required parameters
    if [[ -z "$TARGET" ]]; then
        print_colored "Error: Target URL is required" "error"
        display_help
        exit 1
    fi
}

# Function to check dependencies
check_dependencies() {
    print_colored "[*] Checking dependencies..." "info"
    
    local missing_deps=()
    
    # Check for curl
    if ! command -v curl &> /dev/null; then
        missing_deps+=("curl")
    fi
    
    # Check for tor if enabled
    if [[ "$TOR_ENABLED" == true ]] && ! command -v tor &> /dev/null; then
        missing_deps+=("tor")
    fi
    
    # Check for macchanger if random MAC is enabled
    if [[ "$RANDOM_MAC" == true ]] && ! command -v macchanger &> /dev/null; then
        missing_deps+=("macchanger")
    fi
    
    # Check for proxychains if proxy chains are enabled
    if [[ "$PROXY_CHAINS" == true ]] && ! command -v proxychains &> /dev/null; then
        missing_deps+=("proxychains")
    fi
    
    # If there are missing dependencies, print them and exit
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_colored "[!] Missing dependencies: ${missing_deps[*]}" "error"
        print_colored "[!] Please install the missing dependencies and try again." "error"
        exit 1
    fi
    
    print_colored "[+] All dependencies are installed." "success"
}

# Function to setup Tor
setup_tor() {
    if [[ "$TOR_ENABLED" == true ]]; then
        print_colored "[*] Setting up Tor..." "info"
        
        # Check if Tor is already running
        if pgrep -x "tor" > /dev/null; then
            print_colored "[+] Tor is already running." "success"
        else
            print_colored "[*] Starting Tor..." "info"
            tor --quiet &
            sleep 5
            
            if pgrep -x "tor" > /dev/null; then
                print_colored "[+] Tor started successfully." "success"
            else
                print_colored "[!] Failed to start Tor." "error"
                exit 1
            fi
        fi
    fi
}

# Function to setup random MAC address
setup_random_mac() {
    if [[ "$RANDOM_MAC" == true ]]; then
        print_colored "[*] Setting up random MAC address..." "info"
        
        # Get the default interface
        local interface=$(ip route | grep default | awk '{print $5}')
        
        if [[ -z "$interface" ]]; then
            print_colored "[!] Failed to determine default interface." "error"
            return
        fi
        
        print_colored "[*] Default interface: $interface" "info"
        
        # Backup original MAC address
        local original_mac=$(ip link show $interface | awk '/ether/ {print $2}')
        print_colored "[*] Original MAC address: $original_mac" "info"
        
        # Change MAC address
        print_colored "[*] Changing MAC address..." "info"
        sudo ip link set $interface down
        sudo macchanger -r $interface
        sudo ip link set $interface up
        
        # Verify change
        local new_mac=$(ip link show $interface | awk '/ether/ {print $2}')
        print_colored "[+] New MAC address: $new_mac" "success"
        
        # Register cleanup function
        trap "sudo ip link set $interface down; sudo macchanger -m $original_mac $interface; sudo ip link set $interface up; print_colored '[*] Restored original MAC address.' 'info'" EXIT
    fi
}

# Function to setup DNS randomization
setup_dns_randomization() {
    if [[ "$DNS_RANDOMIZATION" == true ]]; then
        print_colored "[*] Setting up DNS randomization..." "info"
        
        # List of public DNS servers
        local dns_servers=(
            "8.8.8.8"         # Google
            "8.8.4.4"         # Google
            "1.1.1.1"         # Cloudflare
            "1.0.0.1"         # Cloudflare
            "9.9.9.9"         # Quad9
            "149.112.112.112" # Quad9
            "208.67.222.222"  # OpenDNS
            "208.67.220.220"  # OpenDNS
            "64.6.64.6"       # Verisign
            "64.6.65.6"       # Verisign
        )
        
        # Backup original resolv.conf
        if [[ -f /etc/resolv.conf ]]; then
            sudo cp /etc/resolv.conf /etc/resolv.conf.backup
            print_colored "[*] Backed up original resolv.conf" "info"
        fi
        
        # Create new resolv.conf with random DNS servers
        sudo bash -c "echo '# Generated by Enhanced Stealth Module' > /etc/resolv.conf"
        
        # Add 3 random DNS servers
        for i in {1..3}; do
            local random_index=$((RANDOM % ${#dns_servers[@]}))
            local dns_server=${dns_servers[$random_index]}
            sudo bash -c "echo 'nameserver $dns_server' >> /etc/resolv.conf"
            print_colored "[*] Added DNS server: $dns_server" "info"
        done
        
        print_colored "[+] DNS randomization complete." "success"
        
        # Register cleanup function
        trap "sudo cp /etc/resolv.conf.backup /etc/resolv.conf; print_colored '[*] Restored original DNS configuration.' 'info'" EXIT
    fi
}

# Function to setup proxy chains
setup_proxy_chains() {
    if [[ "$PROXY_CHAINS" == true ]]; then
        print_colored "[*] Setting up proxy chains..." "info"
        
        # Check if proxychains.conf exists
        if [[ ! -f /etc/proxychains.conf ]]; then
            print_colored "[!] proxychains.conf not found." "error"
            return
        fi
        
        # Backup original proxychains.conf
        sudo cp /etc/proxychains.conf /etc/proxychains.conf.backup
        print_colored "[*] Backed up original proxychains.conf" "info"
        
        # Create new proxychains.conf
        sudo bash -c "cat > /etc/proxychains.conf << EOF
# proxychains.conf generated by Enhanced Stealth Module

strict_chain
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000

[ProxyList]
# add proxy here ...
# format: type  host  port [user pass]
EOF"
        
        # Add Tor proxy if enabled
        if [[ "$TOR_ENABLED" == true ]]; then
            sudo bash -c "echo 'socks5 127.0.0.1 9050' >> /etc/proxychains.conf"
            print_colored "[*] Added Tor proxy to chain" "info"
        fi
        
        # Add random proxies
        local proxy_types=("http" "socks4" "socks5")
        local proxy_hosts=("proxy1.example.com" "proxy2.example.com" "proxy3.example.com" "proxy4.example.com" "proxy5.example.com")
        local proxy_ports=("3128" "8080" "8118" "1080" "9050")
        
        for ((i=0; i<PROXY_CHAIN_LENGTH; i++)); do
            local random_type=${proxy_types[$((RANDOM % ${#proxy_types[@]}))]}
            local random_host=${proxy_hosts[$((RANDOM % ${#proxy_hosts[@]}))]}
            local random_port=${proxy_ports[$((RANDOM % ${#proxy_ports[@]}))]}
            
            sudo bash -c "echo '$random_type $random_host $random_port' >> /etc/proxychains.conf"
            print_colored "[*] Added proxy to chain: $random_type $random_host:$random_port" "info"
        done
        
        print_colored "[+] Proxy chain setup complete." "success"
        
        # Register cleanup function
        trap "sudo cp /etc/proxychains.conf.backup /etc/proxychains.conf; print_colored '[*] Restored original proxychains configuration.' 'info'" EXIT
    fi
}

# Function to generate random user agent
generate_random_user_agent() {
    local user_agents=(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101 Firefox/90.0"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 11.5; rv:90.0) Gecko/20100101 Firefox/90.0"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_5_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Safari/605.1.15"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.59"
        "Mozilla/5.0 (iPhone; CPU iPhone OS 14_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Mobile/15E148 Safari/604.1"
        "Mozilla/5.0 (iPad; CPU OS 14_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Mobile/15E148 Safari/604.1"
        "Mozilla/5.0 (Android 11; Mobile; rv:90.0) Gecko/90.0 Firefox/90.0"
        "Mozilla/5.0 (Android 11; Mobile; LG-M255; rv:90.0) Gecko/90.0 Firefox/90.0"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 OPR/77.0.4054.277"
    )
    
    echo "${user_agents[$((RANDOM % ${#user_agents[@]}))]}"
}

# Function to perform traffic padding
perform_traffic_padding() {
    if [[ "$TRAFFIC_PADDING" == true ]]; then
        print_colored "[*] Performing traffic padding..." "info"
        
        # Generate random number of requests to decoy sites
        local num_decoys=$((RANDOM % 5 + 1))
        local decoy_sites=(
            "https://www.example.com"
            "https://www.wikipedia.org"
            "https://www.github.com"
            "https://www.stackoverflow.com"
            "https://www.reddit.com"
            "https://www.twitter.com"
            "https://www.facebook.com"
            "https://www.amazon.com"
            "https://www.microsoft.com"
            "https://www.apple.com"
        )
        
        for ((i=0; i<num_decoys; i++)); do
            local random_site=${decoy_sites[$((RANDOM % ${#decoy_sites[@]}))]}
            local user_agent=$(generate_random_user_agent)
            
            if [[ "$VERBOSE" == true ]]; then
                print_colored "[*] Sending decoy request to $random_site" "info"
            fi
            
            # Send request with random user agent
            curl -s -A "$user_agent" "$random_site" > /dev/null
            
            # Random delay
            sleep $((RANDOM % 3 + 1))
        done
        
        print_colored "[+] Traffic padding complete." "success"
    fi
}

# Function to perform timing randomization
perform_timing_randomization() {
    if [[ "$TIMING_RANDOMIZATION" == true ]]; then
        local delay=$((RANDOM % 5 + 1))
        
        if [[ "$VERBOSE" == true ]]; then
            print_colored "[*] Adding random delay of $delay seconds..." "info"
        fi
        
        sleep $delay
    fi
}

# Function to clean logs
clean_logs() {
    if [[ "$LOG_CLEANING" == true ]]; then
        print_colored "[*] Cleaning logs..." "info"
        
        # List of log files to clean
        local log_files=(
            "/var/log/auth.log"
            "/var/log/syslog"
            "/var/log/messages"
            "/var/log/apache2/access.log"
            "/var/log/apache2/error.log"
            "/var/log/nginx/access.log"
            "/var/log/nginx/error.log"
            "/var/log/secure"
            "/var/log/lastlog"
            "/var/log/wtmp"
            "/var/log/btmp"
            "/var/log/utmp"
            "/var/log/faillog"
            "~/.bash_history"
        )
        
        for log_file in "${log_files[@]}"; do
            if [[ -f "$log_file" ]]; then
                if [[ "$VERBOSE" == true ]]; then
                    print_colored "[*] Cleaning log file: $log_file" "info"
                fi
                
                # Clean log file
                sudo bash -c "> $log_file"
            fi
        done
        
        print_colored "[+] Log cleaning complete." "success"
    fi
}

# Function to clean memory
clean_memory() {
    if [[ "$MEMORY_CLEANING" == true ]]; then
        print_colored "[*] Cleaning memory..." "info"
        
        # Sync filesystem
        sync
        
        # Clear page cache, dentries and inodes
        sudo bash -c "echo 3 > /proc/sys/vm/drop_caches"
        
        # Clear swap
        sudo swapoff -a
        sudo swapon -a
        
        print_colored "[+] Memory cleaning complete." "success"
    fi
}

# Function to perform stealth scan
perform_stealth_scan() {
    print_colored "[*] Performing stealth scan on $TARGET..." "info"
    
    # Prepare command
    local cmd="curl -s"
    
    # Add user agent if rotation is enabled
    if [[ "$USER_AGENT_ROTATION" == true ]]; then
        local user_agent=$(generate_random_user_agent)
        cmd="$cmd -A \"$user_agent\""
    fi
    
    # Add custom headers if specified
    if [[ -n "$CUSTOM_HEADERS" && -f "$CUSTOM_HEADERS" ]]; then
        while IFS= read -r header; do
            cmd="$cmd -H \"$header\""
        done < "$CUSTOM_HEADERS"
    fi
    
    # Add custom cookies if specified
    if [[ -n "$CUSTOM_COOKIES" && -f "$CUSTOM_COOKIES" ]]; then
        local cookies=""
        while IFS= read -r cookie; do
            cookies="$cookies; $cookie"
        done < "$CUSTOM_COOKIES"
        
        if [[ -n "$cookies" ]]; then
            cookies="${cookies:2}" # Remove leading "; "
            cmd="$cmd -b \"$cookies\""
        fi
    fi
    
    # Add output file if specified
    if [[ -n "$OUTPUT_FILE" ]]; then
        cmd="$cmd -o \"$OUTPUT_FILE\""
    fi
    
    # Add target
    cmd="$cmd \"$TARGET\""
    
    # Use proxychains if enabled
    if [[ "$PROXY_CHAINS" == true ]]; then
        cmd="proxychains $cmd"
    fi
    
    # Perform traffic padding
    perform_traffic_padding
    
    # Perform timing randomization
    perform_timing_randomization
    
    # Execute command
    if [[ "$VERBOSE" == true ]]; then
        print_colored "[*] Executing: $cmd" "info"
    fi
    
    eval $cmd
    
    print_colored "[+] Scan complete." "success"
    
    # Clean logs and memory if enabled
    clean_logs
    clean_memory
}

# Main function
main() {
    display_banner
    parse_arguments "$@"
    check_dependencies
    setup_tor
    setup_random_mac
    setup_dns_randomization
    setup_proxy_chains
    perform_stealth_scan
}

# Run main function with all arguments
main "$@"
