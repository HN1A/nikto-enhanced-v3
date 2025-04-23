# Nikto Enhanced v3 - Advanced Web Scanner

## Overview
Nikto Enhanced v3 is a comprehensive web server scanner that performs comprehensive tests against web servers for multiple security vulnerabilities. This enhanced version includes advanced features for bypassing protection systems, detecting modern vulnerabilities, and providing an improved user interface.

## Key Features
- Advanced WAF Bypass Techniques
- IDS/IPS Evasion Capabilities including Snort 3 bypass
- 300+ New Vulnerability Checks for 2025
- Enhanced UI with Multiple Color Schemes
- Improved Reporting and Visualization
- AI-Based Protection Evasion
- Multi-Layer Obfuscation Strategies

## Installation
Extract the archive and run the scanner directly:
```
unzip nikto-enhanced-v3.zip
cd nikto-enhanced-v3
chmod +x nikto_enhanced.pl
./nikto_enhanced.pl -h target.com
```

## Command Line Options

### Standard Options
```
-h host          Host(s) to target
-p port          Port(s) to scan
-ssl             Use SSL/HTTPS
-nossl           Disable SSL/HTTPS
-output file     Write output to file
-format format   Output format (csv, json, xml, html)
-dbcheck         Check database and other files for syntax errors
-update          Update databases and plugins
-config file     Use alternative config file
-verbose         Verbose output
-debug           Debug output
-timeout sec     Set the timeout for requests
-root path       Prepend path to all requests
-useproxy        Use the proxy defined in nikto.conf
-nolookup        Do not perform IP->hostname lookups
-nocache         Disable response cache
-evasion tech    Encoding technique to evade IDS/IPS
-plugins         Select which plugins to run
-list-plugins    List all available plugins
-Version         Print version information
-Tuning x        Scan tuning
```

### Enhanced Options
```
-waf             Enable WAF bypass techniques
-ids             Enable IDS/IPS bypass techniques
-bypass          Enable advanced protection bypass
-vuln2025        Enable scanning for 2025 vulnerabilities
-color scheme    Select color scheme (cyber, desert, neon, midnight, blood)
-animation       Enable/disable startup animation
-auto-proxy      Enable automatic proxy discovery
-multi-layer-tor Enable multi-layer Tor routing
-advanced-scan   Enable advanced scanning techniques
-visualization   Enable enhanced visualization features
-snort3-bypass   Enable specific Snort 3 bypass techniques
```

## Protection Bypass Features
Nikto Enhanced v3 includes advanced techniques for bypassing various protection systems:

### WAF Bypass Techniques
- Payload Obfuscation
- HTTP Header Manipulation
- HTTP Parameter Pollution
- Low and Slow Attacks
- Advanced Encoding Techniques

### IDS/IPS Bypass Techniques (including Snort 3)
- Traffic Fragmentation
- Protocol Manipulation
- Payload Encoding
- Behavioral Analysis Evasion
- Timing-based Evasion

### Advanced Protection Bypass Strategies
- Adaptive Evasion
- Multi-layer Obfuscation
- Distributed Scanning
- Protocol Manipulation
- AI-based Evasion

## New Vulnerability Checks
This enhanced version includes 300+ new vulnerability checks for 2025, covering:

- GraphQL Vulnerabilities
- JWT Security Issues
- Server-Side Template Injection
- Prototype Pollution
- WebSocket Security
- API Key Exposure
- Insecure Deserialization
- CORS Misconfigurations
- Server-Side Request Forgery
- Mass Assignment Vulnerabilities
- Insecure Direct Object References
- NoSQL Injection
- XML External Entity Injection
- Open Redirect Vulnerabilities
- Insecure File Upload
- HTTP Request Smuggling
- OAuth 2.0 Vulnerabilities
- WebAuthn Implementation Issues
- API Rate Limit Bypass
- AI Model Injection Attacks
- And many more...

## Enhanced UI Features
- Multiple color schemes (Cyber, Desert, Neon, Midnight, Blood)
- Animated startup sequence
- Progress visualization
- Severity-based color coding
- Improved reporting formats

## Examples

### Basic Scan
```
./nikto_enhanced.pl -h example.com
```

### Scan with WAF Bypass
```
./nikto_enhanced.pl -h example.com -waf
```

### Scan with IDS/IPS Bypass (including Snort 3)
```
./nikto_enhanced.pl -h example.com -ids -snort3-bypass
```

### Comprehensive Scan with All Features
```
./nikto_enhanced.pl -h example.com -waf -ids -bypass -vuln2025 -color cyber -advanced-scan
```

### Scan with Custom Output
```
./nikto_enhanced.pl -h example.com -output results.html -format html -color neon
```

## Plugins
Nikto Enhanced v3 includes numerous plugins for specialized scanning:

- nikto_waf_bypass_advanced.plugin: Advanced WAF bypass techniques
- nikto_ids_ips_bypass.plugin: IDS/IPS bypass techniques
- nikto_advanced_protection_bypass.plugin: Integrated protection bypass
- nikto_vulnerabilities_2025.plugin: 2025 vulnerability checks
- nikto_enhanced_ui_v3.plugin: Enhanced UI features
- nikto_modern_ui.plugin: Modern UI with color schemes
- nikto_snort3_bypass.plugin: Specific Snort 3 bypass techniques
- And many more...

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 2 of the License only.

## Credits
- Original Nikto by Chris Sullo
- Enhanced version by the Enhanced Nikto Project Team
- Additional contributions from the security community

## Disclaimer
This tool is intended for legal security testing only. Users are responsible for obtaining proper authorization before scanning any systems they do not own.
