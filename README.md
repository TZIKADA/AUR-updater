# AUR-updater
Updates every AUR package in the build directory.

**Dependancies:**
```
pacman-contrib
```

Notes:
* The program isn't recursive, all packages (including dependancies) must be cloned to the same build folder.
* It's actually a wrapper, every argument is passed after `pacman -U --needed` so you can use `--ignore` or any other flag that you like.
* The pulling and building happens in parallel so it might eat your RAM and CPU if many updates are pending at once, but you can put a limit to that in */etc/makepkg.conf*.
* It cleans the cached *.pkg* files with paccache so be careful if you need those.
* If your makepkg build destination is not the default it should still work as long as it's in the running directory.

The script can be put inside the build directory and ran from there instead of adding it to PATH (it skips itself so errors won't occur).

Have fun not wasting your time running `git pull` or trying to figure out what `yay` broke this time.
