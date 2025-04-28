<div align="center">

# asdf-dojo

[Dojo](https://github.com/dojoengine/dojo) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
# Always use the full URL to ensure no ambiguity with other plugins.
asdf plugin add dojo https://github.com/dojoengine/asdf-dojo.git
```

If you already had dojo installed and you want to force the update, two choices:
1. Modifying your `~/.asdfrc` and set the [last check duration](asdf plugin add dojo https://github.com/dojoengine/asdf-dojo.git) to 0.
2. Remove and re-add the plugin:
```bash
asdf plugin remove dojo
asdf plugin add dojo https://github.com/dojoengine/asdf-dojo.git
```

Dojo:

```shell
# Show all installable versions
asdf list-all dojo

# Install specific version
asdf install dojo latest

# Set a version globally (on your ~/.tool-versions file)
asdf global dojo latest

# Now dojo commands are available
katana --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/dojoengine/asdf-dojo/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [dojoengine](https://github.com/dojoengine/)
