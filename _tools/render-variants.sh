#!/bin/zsh
# Renders store-art variants (b, c, d) into "Store assets/variants/". Usage: render-variants.sh "<Game folder>" <repo folder>
G="$1"; R="$2"; B="$HOME/Downloads/SSS Projects/$G"; A="$B/$R/store-art"; O="$B/Store assets/variants"; mkdir -p "$O"
CH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
for v in ${=VARIANTS:-b c d}; do
  "$CH" --headless=new --hide-scrollbars --force-device-scale-factor=2 --virtual-time-budget=4000 --window-size=1024,500 --screenshot="$O/tmp.png" "file://$A/art.html?m=banner&ss=2&v=$v" 2>/dev/null
  sips -z 500 1024 "$O/tmp.png" --out "$O/feature-graphic-$v.png" >/dev/null
  "$CH" --headless=new --hide-scrollbars --force-device-scale-factor=2 --virtual-time-budget=4000 --window-size=512,512 --screenshot="$O/tmp.png" "file://$A/art.html?m=icon&s=512&ss=2&v=$v" 2>/dev/null
  sips -z 512 512 "$O/tmp.png" --out "$O/app-icon-$v.png" >/dev/null
done; rm -f "$O/tmp.png"; echo "$G variants: $(ls "$O" | tr '\n' ' ')"
