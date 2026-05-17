#!/bin/sh
uci -q set luci.main.mediaurlbase='/luci-static/bootstrap'
uci -q commit luci
# If apk is available, reinstall bootstrap theme to restore original cascade.css.
if command -v apk >/dev/null 2>&1; then
    apk fix luci-theme-bootstrap 2>/dev/null || true
fi
rm -rf /tmp/luci-* /tmp/luci-indexcache /tmp/luci-modulecache 2>/dev/null
/etc/init.d/rpcd restart 2>/dev/null
/etc/init.d/uhttpd restart 2>/dev/null
echo 'Default LuCI Bootstrap restored.'
