#!/bin/bash
# The time-zone validator accepts the zones tzdata installs (Debian 13 no
# longer ships /usr/share/zoneinfo/posix) and rejects anything else.
set -u
here=$(cd "$(dirname "$0")" && pwd)
v="$here/../tmplscripts/system/time-zone/configd_validate.sh"
fail=0
check() { # check ZONE WANT
    CONFIGD_PATH="/system/time-zone/$1" bash "$v" >/dev/null 2>&1
    got=$?
    if [ "$got" != "$2" ]; then echo "FAIL: $1 -> $got, want $2"; fail=1; else echo "ok: $1"; fi
}
check GMT 0
check UTC 0
check Europe%2FLondon 0
check Etc%2FGMT%2B5 0
check zone.tab 1
check Not%2FA_Zone 1
check ..%2F..%2Fetc%2Fpasswd 1
exit $fail
