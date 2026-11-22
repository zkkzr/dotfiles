#!/bin/sh
out=$(xrandr --query | awk '/ connected/ { o = $1 } /\*/ { for (i = 2; i <= NF; i++) if ($i ~ /\*/) { r = $i; gsub(/[^0-9.]/, "", r); if (r + 0 > best) { best = r + 0; pick = o } } } END { print pick }')
[ -n "$out" ] && xrandr --output "$out" --primary
exit 0
