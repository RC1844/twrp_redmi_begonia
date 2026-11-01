#
# Copyright (C) 2019 Potato Open Sauce Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/redmi/begonia

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := begonia
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := mt6785
TARGET_BOARD_PLATFORM_GPU := mali-g76mc4

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

# Dependencies
ALLOW_MISSING_DEPENDENCIES := true

TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Mkbootimg
BOARD_KERNEL_IMAGE_NAME := kernel
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR  := $(DEVICE_PATH)/prebuilt/dtb

BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/recovery_dtbo

# androidboot.hardware is mandatory: init exports ro.hardware from it before
# loading prop.default, and ro.* is write-once. Without it ro.hardware becomes
# "unknown", so /init.recovery.${ro.hardware}.rc is never imported and none of
# the device services (vendor mount, keymaster/gatekeeper, teei) ever start.
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 androidboot.hardware=mt6785 androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_PAGE_SIZE := 2048
BOARD_HASH_TYPE := sha1
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_TAGS_OFFSET := 0x0bc08000
BOARD_SECOND_OFFSET := 0xbff88000
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_HEADER_SIZE := 1660
BOARD_DTB_SIZE := 165266
BOARD_DTB_OFFSET := 0x0bc08000
BOARD_RECOVERY_DTBO_SIZE := 91536
BOARD_RECOVERY_DTBO_OFFSET := 36708352

BOARD_MKBOOTIMG_ARGS += \
   --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
   --dtb_offset $(BOARD_DTB_OFFSET) \
   --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) \
   --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

# OTA
TARGET_OTA_ASSERT_DEVICE := begonia,begoniain

# Avb
BOARD_AVB_ENABLE := true
BOARD_HEADER_VERSION := 2
BOARD_OS_VERSION := 11.0.0
BOARD_OS_PATCH_LEVEL := 2021-08
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags $(BOARD_HEADER_VERSION)
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS += \
   --prop com.android.build.recovery.fingerprint:$(BUILD_FINGERPRINT_FROM_FILE) \
   --prop com.android.build.boot.os_version:$(BOARD_OS_VERSION) \
   --prop com.android.build.boot.security_patch:$(BOARD_OS_PATCH_LEVEL)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 0x80000
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x4000000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x4000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0xe0000000
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x300000000
BOARD_VENDORIMAGE_PARTITION_SIZE := 0x60000000
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 0x1b000000

# System as root
# BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_SUPPRESS_SECURE_ERASE := true

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
# TARGET_USERIMAGES_USE_F2FS := true

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
# TW_CRYPTO_USE_SYSTEM_VOLD := true

# TWRP specific build flags
TW_DEVICE_VERSION := MIUI_12.5

# UI
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := zh_CN
TW_Y_OFFSET := 80
TW_H_OFFSET := -80
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT  := 2340

# brightness
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 900
TW_SCREEN_BLANK_ON_BOOT := true

TW_OVERRIDE_PROPS_ADDITIONAL_PARTITIONS := vendor system
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_REPACKTOOLS := true
TW_USE_TOOLBOX := true
TW_USES_VENDOR_LIBS := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true

RECOVERY_SDCARD_ON_DATA := true
# BOARD_HAS_NO_REAL_SDCARD := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"

PLATFORM_VERSION := 20.1.0
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_SECURITY_PATCH := 2099-12-31

# PBRP
# PB_TORCH_PATH := /sys/class/leds/torch-light0
# PB_TORCH_MAX_BRIGHTNESS := 4
MAINTAINER := RC1844

#SHRP_Variables
SHRP_DEVICE_CODE := begonia
SHRP_PATH := device/redmi/begonia
SHRP_MAINTAINER := RC1844
SHRP_DARK := true
SHRP_DEVICE_TYPE := A_Only
SHRP_EXTERNAL := /external_sd
SHRP_INTERNAL := /sdcard
SHRP_OTG := /usb_otg

SHRP_FLASH := 1
SHRP_CUSTOM_FLASHLIGHT := true
SHRP_FONP_1 := "/sys/class/leds/led:torch_0"
SHRP_FONP_2 := "/sys/class/leds/led:torch_1"
SHRP_FONP_3 := "/sys/class/leds/led:torch_2"
SHRP_FLASH_MAX_BRIGHTNESS := 4

# SHRP DEFAULT ADDONS
INC_IN_REC_ADDON_1 := true
INC_IN_REC_ADDON_2 := true
INC_IN_REC_ADDON_3 := true
INC_IN_REC_ADDON_4 := true
INC_IN_REC_MAGISK := true

# SHRP_SKIP_DEFAULT_ADDON_1 := true
# SHRP_SKIP_DEFAULT_ADDON_2 := true
# SHRP_SKIP_DEFAULT_ADDON_3 := true
# SHRP_SKIP_DEFAULT_ADDON_4 := true

SHRP_REC := /dev/block/platform/bootdevice/by-name/recovery
