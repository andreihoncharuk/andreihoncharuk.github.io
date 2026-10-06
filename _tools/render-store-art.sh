#!/bin/zsh
# Renders the store icon, round icon and feature graphic for a web game from its store-art/art.html,
# at 2x and downscaled, then installs them into "Store assets" and the Android launcher icons.
# Usage: render-store-art.sh "<Game folder>" <repo folder>
set -e
G="$1"; R="$2"; V="${3:+&v=$3}"; B="$HOME/Downloads/SSS Projects/$G"; A="$B/$R/store-art"; S="$B/Store assets"; RES="$B/$R/android/app/src/main/res"
CH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
shot() { "$CH" --headless=new --hide-scrollbars --force-device-scale-factor=2 --default-background-color=00000000 --virtual-time-budget=6000 --window-size=$1 --screenshot="$2" "file://$A/art.html?$3&ss=2$V" 2>/dev/null; }
shot 1024,500 "$A/feature-graphic@2x.png" "m=banner"
shot 512,512 "$A/icon@2x.png" "m=icon&s=512"
shot 512,512 "$A/icon-round@2x.png" "m=icon&s=512&round=1"
sips -z 500 1024 "$A/feature-graphic@2x.png" --out "$A/feature-graphic.png" >/dev/null
sips -z 512 512 "$A/icon@2x.png" --out "$A/icon-512.png" >/dev/null
sips -z 512 512 "$A/icon-round@2x.png" --out "$A/icon-round-512.png" >/dev/null
cp "$A/icon-512.png" "$S/app-icon-512.png"; cp "$A/feature-graphic.png" "$S/feature-graphic-1024x500.png"
for dk in mdpi:48:72 hdpi:72:108 xhdpi:96:144 xxhdpi:144:216 xxxhdpi:192:288; do d=${dk%%:*}; rest=${dk#*:}; L=${rest%%:*}; F=${rest##*:}
  sips -z $L $L "$A/icon@2x.png" --out "$RES/mipmap-$d/ic_launcher.png" >/dev/null
  sips -z $L $L "$A/icon-round@2x.png" --out "$RES/mipmap-$d/ic_launcher_round.png" >/dev/null
  sips -z $F $F "$A/icon@2x.png" --out "$RES/mipmap-$d/ic_launcher_foreground.png" >/dev/null
done
rm -f "$A"/*@2x.png
echo "$G: done"
