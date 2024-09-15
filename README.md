# DNS-changer
A cross-platform CLI tool for swift, effortless switching between predefined DNS configurations on macOS.

DNS changer is a simple, flexible system for managing DNS settings on macOS. It allows you to quickly switch between predefined DNS configurations.

## Features

- Easily switch between predefined DNS configurations
- Auto-completion for DNS names
- Simple text-based configuration file for easy manual editing

## Installation

1. Clone this repository or download the scripts to your local machine.

2. Run the installer script:
   ```
   sudo bash install.sh
   ```

   This will:
   - Install the main `setdns` script
   - Set up the configuration file
   - Install and configure bash completion

3. Restart your terminal or run `source ~/.bash_profile` to enable completion.

## Usage

To change your DNS settings, use the `setdns` command with sudo:

```
sudo setdns <dns_name>
```

For example:
```
sudo setdns electro
```

To see available options and usage information:
```
setdns --help
```

## Configuration

The DNS configurations are stored in `/usr/local/etc/dns_settings.txt`. Each line in this file represents a DNS configuration in the following format:

```
<name> <ip1> <ip2> ...
```

For example:
```
electro 78.157.42.101 78.157.42.100
```

You can edit this file manually to add, remove, or modify DNS configurations.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Acknowledgements

This project was inspired by the need for a simple, flexible DNS management system for macOS.