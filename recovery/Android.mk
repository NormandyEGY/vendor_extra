RECOVERY_PATH := $(call my-dir)

ifeq ($(strip $(BOARD_COMPILE_TWRP)),true)
TARGET_RECOVERY_FSTAB := vendor/extra/recovery/twrp.fstab
TW_FLASH_FROM_STORAGE := true
TW_INTERNAL_STORAGE_PATH := "/sdcard1"
TW_EXTERNAL_STORAGE_PATH := "/sdcard"
TW_DEFAULT_EXTERNAL_STORAGE := true
$(shell [ -f $(PRODUCT_OUT)/recovery/root/etc/ ] || mkdir -p $(PRODUCT_OUT)/recovery/root/etc/)
$(shell cp $(RECOVERY_PATH)/twrp.fstab $(PRODUCT_OUT)/recovery/root/etc/twrp.fstab)
else
TARGET_RECOVERY_FSTAB := device/nokia/normandy/rootdir/fstab.qcom
endif

