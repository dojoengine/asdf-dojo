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
	chmod +x "$ASDF_DOWNLOAD_PATH/dojoup"
}
