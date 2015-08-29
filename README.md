# vendor_extra
Nokia X extra files

## What is this ?
=====================
This is some files and apps taken from old Nokia x roms and other android sources .... These files are necessary for compilation sucess

##How to use it ?
=====================
You can use it by sync our local_manifest.xml as this

`curl -L -o .repo/local_manifests/normandylp.xml -O -L https://raw.github.com/NormandyLP/local_manifests/master/normandylp.xml`

or you can clone it to `vendor/extra` as this
`git clone git://github.com/NormandyLP/vendor_extra.git -b Lollipop5.1`

##If i want to use it with any other source or other qcom msm7x27a device which is the same as Nokia x , how can i do this ?

You must clone it to `vendor/extra` and write this line to your Android.mk of your device or boardconfig.mk
`include vendor/extra/Android.mk`

###NORMANDY LP TEAM
