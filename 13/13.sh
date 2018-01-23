#!/bin/bash
foremost challenge_13_2433.jpg 2>&1 >/dev/null
unzip output/zip/*.zip 2>&1 >/dev/null
steghide extract -sf water.jpg 2>&1 >/dev/null
rm text.txt
steghide extract -sf meadow.jpg 2>&1 >/dev/null
pass=$(tail -1 text.txt)
rm text.txt
steghide extract -sf forest.jpg -p $pass 2>&1 >/dev/null
cat text.txt
rm text.txt
rm -rf output/ forest.jpg meadow.jpg water.jpg
