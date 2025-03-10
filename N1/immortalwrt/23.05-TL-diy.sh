#!/bin/bash

# Default IP
sed -i 's/192.168.1.1/192.168.123.2/g' package/base-files/files/bin/config_generate
# 修改主机名
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

# Add packages
git clone https://github.com/ophub/luci-app-amlogic --depth=1 package/amlogic
git clone https://github.com/xiaorouji/openwrt-passwall --depth=1 package/passwall
git clone https://github.com/xiaorouji/openwrt-passwall2 --depth=1 package/passwall2
git clone https://github.com/xiaorouji/openwrt-passwall-packages
git clone https://github.com/gdy666/luci-app-lucky.git package/lucky
git clone https://github.com/sbwml/luci-app-alist package/alist

rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 修复v2ray-plugin编译失败
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang


# 尝试修复openwrt-23.05中rust编译失败的问题
rm -rf package/passwall-packages/{shadowsocks-rust,v2ray-geodata}

temp_dir=$(mktemp -d)
git clone https://github.com/coolsnowwolf/lede "$temp_dir"

cp -r "$temp_dir/shadowsocks-rust" package/passwall-packages/
cp -r "$temp_dir/v2ray-geodata" package/passwall-packages/

rm -rf "$temp_dir"
echo "Packages merged successfully."

