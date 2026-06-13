#!/usr/bin/bash

echo "Starting update process"
echo ""

directories=(*/)

echo "Downloading updates..."
for dir in "${directories[@]}"; do
	git -C "$dir" pull &> /dev/null || echo "FAILED TO FETCH: ${dir%/}." &
done
wait
echo "Done."

echo ""
echo "Rebuilding..."
for dir in "${directories[@]}"; do
	{ makepkg --dir "$dir" -rc &>/dev/null; (( $? == 0 || $? == 13 )); } || \
		echo "FAILED TO BUILD: ${dir%/}." &
done
wait
echo "Done."

echo ""

# Remove old .pkg files
args=()
for dir in "${directories[@]}"; do
	args+=(-c "$dir")
done
paccache --remove --keep 1 "${args[@]}" &> /dev/null

sudo pacman -U --needed $@ */*.pkg*

echo ""
echo "Done."
