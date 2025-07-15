#!/bin/bash

# Path to the text configuration file
CONFIG_FILE="/usr/local/etc/dns_settings.txt"

# Function to display help message
show_help() {
    echo "Usage: $0 [OPTION] <dns_name> [ip1 ip2 ...]"
    echo "Set DNS servers for Wi-Fi interface."
    echo
    echo "Options:"
    echo "  -h, --help        Display this help message and exit"
    echo "  -a, --add         Add a new DNS configuration"
    echo "  -d, --delete      Delete a DNS configuration"
    echo
    echo "Available DNS options:"
    awk '{print $1}' "$CONFIG_FILE"
    echo
    echo "Examples:"
    echo "  sudo $0 dns"
    echo "  sudo $0 --add newdns 1.1.1.1 1.0.0.1"
    ech0 "  sudo $0 --delete olddns"
}

# Check for help option
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# ADD DNS
if [[ "$1" == "--add" || "$1" == "-a" ]]; then
    if [ $# -lt 3 ]; then
        echo "Usage: $0 --add <name> <ip1> [ip2 ...]"
        exit 1
    fi
    name="$2"
    shift 2
    # Remove old entry with same name if exists
    grep -v "^$name " "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
    echo "$name $*" >> "$CONFIG_FILE"
    echo "DNS '$name' added with IPs: $*"
    exit 0
fi


# DELETE DNS
if [[ "$1" == "--delete" || "$1" == "-d" ]]; then
    if [ -z "$2" ]; then
        echo "Usage: $0 --delete <name>"
        exit 1
    fi
    name="$2"
    if grep -q "^$name " "$CONFIG_FILE"; then
        grep -v "^$name " "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
        echo "DNS '$name' deleted."
    else
        echo "DNS '$name' not found."
    fi
    exit 0
fi

# Check if an argument is provided
if [ $# -eq 0 ]; then
    read -p "Enter DNS name: " name
fi

name=$1

# Read DNS settings from text file and set DNS
if dns_servers=$(awk -v name="$name" '$1 == name {$1=""; print $0}' "$CONFIG_FILE"); then
    if [ -n "$dns_servers" ]; then
        networksetup -setdnsservers Wi-Fi $dns_servers
        echo "DNS set to '$name' ($dns_servers)"
        exit 0
    fi
fi

echo "Invalid DNS name. Use '$0 --help' to see available options."
exit 1
