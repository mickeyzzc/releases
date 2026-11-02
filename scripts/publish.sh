#!/usr/bin/env bash
# publish.sh — create a GitHub Release on this repository for one product version.
#
# Usage:
#   scripts/publish.sh <product> <version> <notes.md> <asset>...
#
#   product   a product registered in products/registry.txt that has a guide
#             at products/<product>/README.md
#   version   semver without the leading "v", e.g. 1.2.3 or 1.3.0-rc.1
#   notes.md  release notes (start from scripts/release-notes.md)
#   asset     files to upload; checksums.txt is verified when supplied and
#             generated when not
#
# Environment:
#   RELEASES_REPO      target repository (default: mickeyzzc/releases)
#   RELEASES_DENYLIST  extended regex; abort when the notes match it
#                      (keep the real pattern outside this public repository)
#   PUBLISH=1          publish immediately instead of creating a draft
#   DRY_RUN=1          print the gh command instead of running it
#
# Requires gh (authenticated, with write access to the target repository)
# and sha256sum or shasum.
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
REGISTRY="$ROOT/products/registry.txt"
REPO="${RELEASES_REPO:-mickeyzzc/releases}"

die() {
	echo "publish: $*" >&2
	exit 1
}

sha256_of() {
	if command -v sha256sum >/dev/null 2>&1; then
		sha256sum "$1" | awk '{print $1}'
	else
		shasum -a 256 "$1" | awk '{print $1}'
	fi
}

[ $# -ge 4 ] || die "usage: $0 <product> <version> <notes.md> <asset>..."
product=$1
version=$2
notes=$3
shift 3

[[ $product =~ ^[a-z0-9][a-z0-9-]*$ ]] || die "product '$product' must use lowercase letters, digits and '-'"
[ -f "$REGISTRY" ] || die "registry not found: $REGISTRY"
title=$(awk -v p="$product" '{ sub(/\r$/, "") } $1 == p { $1 = ""; sub(/^[ \t]+/, ""); print; exit }' "$REGISTRY")
if [ -z "$title" ]; then
	known=$(awk '{ sub(/\r$/, "") } !/^#/ && NF { printf "%s ", $1 }' "$REGISTRY")
	die "product '$product' is not registered in products/registry.txt (registered: ${known:-none})"
fi
[ -f "$ROOT/products/$product/README.md" ] || die "products/$product/README.md is missing — write the product guide first"

[[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]] ||
	die "version '$version' is not semver (write 1.2.3, not v1.2.3)"
[ -s "$notes" ] || die "notes file '$notes' is missing or empty"

if [ -n "${RELEASES_DENYLIST:-}" ]; then
	rc=0
	grep -nEi -- "$RELEASES_DENYLIST" "$notes" >&2 || rc=$?
	[ "$rc" -eq 1 ] || die "notes match RELEASES_DENYLIST (lines above) or the pattern is invalid"
fi

assets=()
sums=""
for f in "$@"; do
	[ -f "$f" ] || die "asset '$f' not found"
	if [ "$(basename "$f")" = checksums.txt ]; then
		sums=$f
	fi
	assets+=("$f")
done

dups=$(for f in "${assets[@]}"; do basename "$f"; done | sort | uniq -d)
[ -z "$dups" ] || die "duplicate asset names: $dups"

if [ -n "$sums" ]; then
	for f in "${assets[@]}"; do
		[ "$f" = "$sums" ] && continue
		b=$(basename "$f")
		want=$(awk -v n="$b" '{ sub(/\r$/, "") } $2 == n || $2 == "*" n { print $1; exit }' "$sums")
		[ -n "$want" ] || die "checksums.txt has no entry for $b"
		[ "$want" = "$(sha256_of "$f")" ] || die "checksum mismatch for $b"
	done
	echo "publish: checksums.txt verified"
else
	tmp=$(mktemp -d)
	trap 'rm -rf "$tmp"' EXIT
	for f in "${assets[@]}"; do
		printf '%s  %s\n' "$(sha256_of "$f")" "$(basename "$f")"
	done >"$tmp/checksums.txt"
	echo "publish: generated checksums.txt for ${#assets[@]} file(s)"
	assets+=("$tmp/checksums.txt")
fi

tag="${product}-v${version}"
args=(release create "$tag" --repo "$REPO" --target main
	--title "$title v$version" --notes-file "$notes")
if [[ $version == *-* ]]; then
	args+=(--prerelease)
fi
if [ "${PUBLISH:-0}" != 1 ]; then
	args+=(--draft)
fi

if [ "${DRY_RUN:-0}" = 1 ]; then
	printf 'DRY_RUN: gh'
	printf ' %q' "${args[@]}" "${assets[@]}"
	printf '\n'
	exit 0
fi

command -v gh >/dev/null 2>&1 || die "GitHub CLI (gh) not found"
if gh release view "$tag" --repo "$REPO" >/dev/null 2>&1; then
	die "release $tag already exists on $REPO"
fi

gh "${args[@]}" "${assets[@]}"

if [ "${PUBLISH:-0}" = 1 ]; then
	echo "publish: released $tag"
else
	echo "publish: draft $tag created — review it on GitHub, then publish with:"
	echo "  gh release edit $tag --repo $REPO --draft=false"
fi
