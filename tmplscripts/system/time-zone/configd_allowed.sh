#!/bin/bash
# Compiled zones under /usr/share/zoneinfo (Debian 13 has no posix/ subtree).
cd /usr/share/zoneinfo && find . -type f -follow ! -path './right/*' ! -path './posix/*' \
    -exec sh -c 'for f; do [ "$(head -c 4 "$f")" = TZif ] && printf "%s\n" "${f#./}"; done' sh {} + | sort
