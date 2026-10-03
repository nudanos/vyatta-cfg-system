#!/bin/bash
new_zone=$(basename $CONFIGD_PATH)
new_zone=${new_zone//\%2B/+}
new_zone=${new_zone//\%2F//}
# Debian 13 no longer ships /usr/share/zoneinfo/posix: accept a compiled zone
# file (TZif) directly under /usr/share/zoneinfo, and no path tricks.
f=/usr/share/zoneinfo/$new_zone
case "$new_zone" in
    */../*|../*|*/..|..) ;;
    *)
        if [ -f "$f" ] && [ "$(head -c 4 "$f")" = TZif ]; then
            exit 0
        fi
        ;;
esac

echo "ERROR: $new_zone is not a valid time-zone"
exit 1
