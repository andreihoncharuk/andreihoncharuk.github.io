# Store-art tooling

Renders the Play Store icon, round icon and feature graphic for a game from
its own `store-art/art.html`, using headless Chrome, then installs the results
into `Store assets/` and every Android launcher density.

    ./render-store-art.sh "Outpost Zero" outpost-zero-app
    ./render-variants.sh  "Outpost Zero" outpost-zero-app     # b, c, d
    VARIANTS="e f g" ./render-variants.sh "Outpost Zero" outpost-zero-app

`sheet.html` lays the variants side by side for comparison. It resolves images
relative to itself, so pass an absolute folder:

    file:///Users/andrei/Documents/GitHub/andreihoncharuk.github.io/_tools/sheet.html?d=/Users/andrei/Downloads/SSS%20Projects/Outpost%20Zero/Store%20assets/variants&v=defg

Both scripts build every path from `$HOME/Downloads/SSS Projects/<game>`, so
they run from anywhere and do not care where this folder sits.

The leading underscore keeps GitHub Pages from publishing this folder: Jekyll
skips paths beginning with `_`. The repository itself is public, so never put
a token or key in here.
