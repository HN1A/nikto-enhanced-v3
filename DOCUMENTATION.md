# Nikto Enhanced v3.5 - Documentation

## Overview

Nikto Enhanced v3.5 is an advanced web server scanner with significantly improved capabilities for security testing, protection bypass, and vulnerability detection. This enhanced version builds upon the original Nikto scanner with additional features, improved visualization, and more comprehensive scanning capabilities.

## New Features in v3.5

### Enhanced Scanning Capabilities

- **Deep Scanning**: Multi-level deep scanning (levels 1-5) for thorough analysis of web applications
- **AI-Assisted Scanning**: Simulated AI analysis to identify potential vulnerabilities based on response patterns
- **Adaptive Scanning**: Dynamically adjusts scanning techniques based on server responses
- **Scan Speed Control**: Adjust scan speed (slow, normal, fast) based on your requirements
- **Scan Accuracy Control**: Set accuracy level (low, medium, high) to balance between speed and thoroughness

### Advanced Protection Bypass

- **WAF Bypass**: Advanced techniques to bypass Web Application Firewalls
  - Automatic WAF detection for 15+ WAF vendors
  - Multiple bypass techniques including header manipulation, parameter pollution, payload obfuscation
  - 5 levels of bypass intensity
  
- **IDS/IPS Bypass**: Sophisticated methods to evade Intrusion Detection/Prevention Systems
  - Traffic normalization
  - Protocol ambiguity
  - Polymorphic payloads
  - Session splicing
  
- **Snort3 Bypass**: Specialized techniques for bypassing Snort3 detection
  - Stream segmentation
  - Rule evasion
  - Signature evasion
  - Protocol violations

### Improved Visualization

- **10 Color Schemes**: Choose from cyber, desert, neon, midnight, blood, matrix, sunset, ocean, forest, aurora
- **Auto Color Rotation**: Colors automatically change on each execution for a fresh experience
- **Animated Banner**: Dynamic startup banner with loading animations
- **Enhanced Reporting**: Visual charts and graphs for vulnerability distribution
- **Severity Highlighting**: Color-coded output based on vulnerability severity

### Additional Features

- **300 New Vulnerability Rules**: Expanded database with modern vulnerability checks
- **Multi-language Support**: Scripts in Python, Bash, and Go for extended functionality
- **English-Only Interface**: Consistent English interface throughout the tool
- **Comprehensive Documentation**: Detailed documentation of all features and commands

## Command Line Options

Nikto Enhanced v3.5 includes 95+ command line options. Here are the most important new options:

### Scanning Options

```
--deep-scan                Enable deep scanning capabilities
--scan-level <1-5>         Set the scan depth level (default: 3)
--scan-speed <slow|normal|fast>  Set scan speed (default: normal)
--scan-accuracy <low|medium|high>  Set scan accuracy (default: high)
--ai-scan                  Enable AI-assisted scanning
--adaptive-scan            Enable adaptive scanning
```

### Protection Bypass Options

```
--waf-bypass               Enable WAF bypass techniques
--waf-evasion-level <1-5>  Set WAF evasion level (default: 3)
--ids-bypass               Enable IDS/IPS bypass techniques
--ids-evasion-level <1-5>  Set IDS evasion level (default: 3)
--snort3-bypass            Enable Snort3 bypass techniques
--snort3-evasion-level <1-5>  Set Snort3 evasion level (default: 3)
```

### Visualization Options

```
--color-scheme <scheme>    Set color scheme (cyber, desert, neon, midnight, blood, matrix, sunset, ocean, forest, aurora)
--no-colors                Disable colored output
--no-animation             Disable animated banner
--english-only             Force English-only interface
```

### Extended Database Options

```
--vuln2025                 Enable 2025 vulnerability checks
--extended-db              Use extended vulnerability database (300+ rules)
```

## Usage Examples

### Basic Scan with Enhanced Features

```bash
./nikto_enhanced.pl -h target.com --deep-scan --scan-level 3
```

### Scan with Protection Bypass

```bash
./nikto_enhanced.pl -h target.com --waf-bypass --ids-bypass --snort3-bypass
```

### Full Featured Scan

```bash
./nikto_enhanced.pl -h target.com --deep-scan --ai-scan --adaptive-scan --waf-bypass --ids-bypass --extended-db --color-scheme cyber
```

### Stealth Scan

```bash
./nikto_enhanced.pl -h target.com --ids-bypass --snort3-bypass --scan-speed slow --waf-evasion-level 5
```

## Integration with External Tools

### Python Integration

The enhanced scanner includes Python scripts for extended functionality:

```bash
./wrappers/enhanced_scanner.py --target target.com --output report.json
```

### Bash Integration

Use the Bash scripts for additional stealth capabilities:

```bash
./wrappers/enhanced_stealth.sh target.com
```

### Go Integration

The Go-based evasion tool provides additional protection bypass techniques:

```bash
./wrappers/enhanced_evasion target.com
```

## Protection Bypass Techniques

### WAF Bypass Techniques

- Header Manipulation
- Parameter Pollution
- Payload Obfuscation
- Protocol Manipulation
- Timing Manipulation
- Case Randomization
- Unicode Encoding
- Double Encoding
- Null Byte Injection
- Comment Injection
- Whitespace Manipulation
- HTTP Method Override
- Content Type Manipulation
- Chunked Encoding
- Path Normalization

### IDS/IPS Bypass Techniques

- Packet Fragmentation
- Traffic Normalization
- Protocol Ambiguity
- Timing Evasion
- Session Splicing
- Polymorphic Payloads
- Decoy Traffic
- TTL Manipulation
- IP Fragmentation
- Overlapping Fragments
- Invalid Checksums
- Unusual MTU Sizes
- Out of Order Packets
- Session Timeout Manipulation

### Snort3 Bypass Techniques

- Stream Segmentation
- Rule Evasion
- Preprocessor Evasion
- Flow Manipulation
- Signature Evasion
- Protocol Violation
- State Manipulation
- Buffer Manipulation
- Content Length Manipulation
- HTTP Pipelining
- HTTP Chunking
- HTTP Compression
- TCP Options Manipulation
- IP Options Manipulation

## Vulnerability Categories

The enhanced vulnerability database includes checks for:

- GraphQL Vulnerabilities
- JWT Security Issues
- Server-Side Template Injection (SSTI)
- Prototype Pollution
- WebSocket Security Issues
- API Key Leakage
- Insecure Deserialization
- Server-Side Request Forgery (SSRF)
- NoSQL Injection
- XML External Entity (XXE)
- Cross-Site Script Inclusion (XSSI)
- DOM-based Vulnerabilities
- Content Security Policy Bypass
- HTTP Request Smuggling
- HTTP Response Splitting
- Web Cache Poisoning
- OAuth 2.0 Vulnerabilities
- CORS Misconfigurations
- Host Header Injection
- HTTP Parameter Pollution
- Path Traversal Variants
- File Upload Vulnerabilities
- Insecure Direct Object References
- Business Logic Vulnerabilities
- Race Conditions

## Changelog

### v3.5.0 (2025-04-23)
- Added auto color rotation feature
- Enhanced protection bypass techniques
- Added advanced visualization with 10 color schemes
- Implemented AI-assisted scanning
- Added adaptive scanning capabilities
- Expanded vulnerability database to 300+ rules
- Added multi-language script support (Python, Bash, Go)
- Improved reporting with visual charts

### v3.0.0 (2025-03-15)
- Initial enhanced release
- Added WAF bypass capabilities
- Added IDS/IPS bypass capabilities
- Added 25 new vulnerability checks
- Improved user interface with color support

## Credits

Nikto Enhanced v3.5 is based on the original Nikto scanner with significant enhancements.

- Original Nikto: https://github.com/sullo/nikto
- Enhanced by: Nikto Enhanced Project Team (2025)

## License

This software is provided under the same terms as the original Nikto scanner.
