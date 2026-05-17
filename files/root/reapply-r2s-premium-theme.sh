#!/bin/sh
uci -q set luci.main.mediaurlbase='/luci-static/bootstrap'
uci -q commit luci
CSS_SRC='/etc/r2s-premium/premium-override.css'
CSS_DST='/www/luci-static/bootstrap/cascade.css'
if [ -f "$CSS_SRC" ] && [ -f "$CSS_DST" ]; then
    if ! grep -q 'R2S_PREMIUM_V3_START' "$CSS_DST" 2>/dev/null; then
        echo '' >> "$CSS_DST"
        echo '/* R2S_PREMIUM_V3_START */' >> "$CSS_DST"
        cat "$CSS_SRC" >> "$CSS_DST"
        echo '/* R2S_PREMIUM_V3_END */' >> "$CSS_DST"
    fi
fi
rm -rf /tmp/luci-* /tmp/luci-indexcache /tmp/luci-modulecache 2>/dev/null
/etc/init.d/rpcd restart 2>/dev/null
/etc/init.d/uhttpd restart 2>/dev/null
echo 'R2S Premium V3 theme applied. Open http://192.168.1.1'
