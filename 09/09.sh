#!/bin/bash
foremost -Q meow.pdf
convert output/jpg/00000002.jpg -fuzz 2% -fill red -opaque white test.jpg
tesseract test.jpg stdout | head -1
rm -rf output test.jpg
echo "try to change this    ^ for a lower case L"
