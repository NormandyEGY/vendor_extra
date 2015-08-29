#!/bin/sh
#
# Copyright (C) 2015 OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# cleanup screen
clear;

# resolutions
# based on stock 600x400px Omni bootanimation (30fps)
RESOLUTIONS="\
    480x300
    ";

# resize image and set quality
convert_image() {
    convert "${1}" -resize "${2}" -quality ${3} tmp.jpg;
    mv tmp.jpg "${1}";
}

# rewrite desc.txt
rewrite_desc() {
res=$(echo "${1}" | sed s/x/\ /)
cat > desc.txt << EOF
${res} 30

c 1 300 part0

c 1 0 part1

c 0 0 part2

c 1 100 part3

c 1 25 part4

c 1 0 part5
EOF
}

# image quality
quality=50;

# reading images
for i in ${RESOLUTIONS}; do

#   cleanup environment
    rm -rf "${i}";
    rm -rf "${i}.zip";

#   create a temporary folder
    mkdir -p "${i}";
    cd ${i};

    echo "============================================================";
    echo "Resolution: ${i}"
    echo "============================================================";
    echo "Uncompressing bootanimation...";
    [ -f ../../../pa/prebuilt/bootanimation ] || unzip ../../../omni/prebuilt/bootanimation/bootanimation.zip > /dev/zero;
    [ -f ../../../omni/prebuilt/bootanimation/ ] || unzip ../../../pa/prebuilt/bootanimation/1920x1080.zip > /dev/zero;

    echo "Rewriting desc.txt...";
    rewrite_desc "${i}"

    echo "Resizing images...";
    for j in Part*/*.jpg; do
        convert_image "${j}" "${i}" $quality;
        echo -ne " ==> please wait...\r";
    done

    echo "";
    echo "Compressing bootanimation...";
    echo "";
    zip -r0 ../${i}.zip . > /dev/zero;

    sleep 1;
    echo "Done";

#   remove temporary folder
    cd ..
    rm -rf ${i}
done
