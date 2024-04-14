# asdf-dojo

`asdf-dojo` is a plugin for the [asdf](https://github.com/asdf-vm/asdf) version manager, enabling the management of
multiple versions of Dojo.

## Prerequisites

Before you install the `asdf-dojo` plugin, make sure you have:

- `bash` - Most Unix-like operating systems have this installed by default.
- `curl` - Used for downloading dependencies.
- Generic POSIX utilities (like `awk`, `sed`, `grep`).

Ensure that your system meets these requirements to avoid issues with plugin installation and operation.

## Installation

To install the `asdf-dojo` plugin, use one of the following methods:

### From the Default Repository

```shell
asdf plugin add dojo
```

### From a Custom Repository

If you prefer to install from a specific repository:

```shell
asdf plugin add dojo https://github.com/dojoengine/asdf-dojo
```

## Usage

### Listing Versions

To list all installable versions of Dojo:

```shell
asdf list-all dojo
```

### Installing Versions

To install the latest stable version of Dojo:

```shell
asdf install dojo latest
```

To install a specific version of Dojo:

```shell
asdf install dojo 0.5.0
```

### Setting a Version Globally

To set a global version of Dojo:

```shell
asdf global dojo 0.5.0
```

## Troubleshooting

If you encounter any errors during installation or while using the plugin, ensure that all system dependencies are installed. For issues related to `asdf` commands, refer to the [asdf documentation](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf) or file an issue on the GitHub issue tracker.

## Contributing

Contributions to the `asdf-dojo` plugin are welcome!

## License

This project is licensed under [MIT License](LICENSE).
