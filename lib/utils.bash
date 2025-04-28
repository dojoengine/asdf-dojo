#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/dojoengine/dojo"
TOOL_NAME="dojo"
TOOL_BINS=(sozo katana torii dojo-language-server)

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# Change this function if Dojo has other means of determining installable versions.
	list_github_tags
}

download_dojoup() {
	url="https://raw.githubusercontent.com/dojoengine/dojo/refs/heads/main/dojoup/dojoup"
	curl "${curl_opts[@]}" -o "$ASDF_DOWNLOAD_PATH/dojoup" -C - "$url" || fail "Could not download Dojoup from $url"
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	# Build the URL to download the release tarball
	local tag os arch
	tag="v${version}"
	arch=$(uname -m)
	if [ "$arch" == "x86_64" ] 
	then
		arch="amd64"
	fi
	if [ "$arch" == "aarch64" ] 
	then
		arch="arm64"
	fi
	os=$(uname -s)
	os=$(echo ${os} | tr '[:upper:]' '[:lower:]') # Convert the OS name to lowercase

	local tarball="dojo_${tag}_${os}_${arch}.tar.gz"
	url="${GH_REPO}/releases/download/${tag}/${tarball}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# Ensure all binaries exist and executable
		for bin in "${TOOL_BINS[@]}"; do
			test -x "$install_path/$bin" || fail "Expected $install_path/$bin to be executable."
		done

		echo "$TOOL_NAME $version installation was successful!"

	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
