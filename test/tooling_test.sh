#!/bin/sh

set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

hwt config validate "$root/.hwt-config/hwt/localhost.yaml"
hwt config validate "$root/.hwt-config/hwt/dnsmasq-caddy.yaml"
