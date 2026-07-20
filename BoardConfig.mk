# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/herofun/BH502G

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# A/B Configurations
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    product \
    system_ext \
    vendor \
    vbmeta_system \
    vbmeta_vendor \
    boot \
    system
BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
# TARGET_CPU_ABI2 intentionally empty for pure 64-bit primary
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := tb8768p1_64_bsp
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 240

# Kernel Parameters
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x11a88000
BOARD_KERNEL_TAGS_OFFSET := 0x07808000
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_CONFIG := BH502G_defconfig
TARGET_KERNEL_SOURCE := kernel/herofun/BH502G

# Consolidated Boot Image Arguments
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOTIMG_HEADER_VERSION) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

# Kernel - Prebuilt Mapping
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
# Clear in-bootimg DTB since we use separate prebuilt DTB
BOARD_INCLUDE_DTB_IN_BOOTIMG :=
endif

# Partition Sizes & Filesystem Definitions
BOARD_FLASH_BLOCK_SIZE := 131072
# Boot image size: 64MB (tricked compiler limit for successful image save)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
# Recovery image size: 64MB (unused with recovery-as-boot but kept for compatibility)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := herofun_dynamic_partitions
BOARD_HEROFUN_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product
BOARD_HEROFUN_DYNAMIC_PARTITIONS_SIZE := 9122611200

# Platform
TARGET_BOARD_PLATFORM := mt6765

# Recovery Options
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_USERIMAGES_USE_EXT4 := true
# Stock uses ext4 for userdata — disable f2fs to prevent mount conflicts
TARGET_USERIMAGES_USE_F2FS := false

# Verified Boot
BOARD_AVB_ENABLE := true
# --flags 3: disable verification + disable rollback (required for custom recovery)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Align Version System Flags (Critical for Keymaster Verification matching Android 13 OS)
PLATFORM_VERSION := 13
PLATFORM_SECURITY_PATCH := 2024-07-05
VENDOR_SECURITY_PATCH := 2024-07-05

# Extreme Binary Stripping for GZIP Size Compliance (Strict 32MB Ceiling Limit)
BOARD_RAMDISK_COMPRESSION := gzip
TW_EXTRA_LANGUAGES := false
TW_INCLUDE_REPACKTOOLS := false

# Re-enabled resetprop framework (Essential for MTK property initialization loop)
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true

# Pure TWRP Minimal Framework Options (Removes heavy assets & animations)
TW_MINIMAL_UI := true
DISABLE_RECOVERY_DUMPBACK := true
TW_NO_REBOOT_BOOTLOADER := true
TW_MAX_BRIGHTNESS := 255

# Drop heavy modules to make room for decryption binaries
TW_EXCLUDE_APTWIPE := true
TW_EXCLUDE_FB2PNG := true
TW_EXCLUDE_TZDATA := true
TW_EXCLUDE_BASH := true
TW_EXCLUDE_MTP := true
TW_SUPPORT_INPUT_1_2 := false
TW_INCLUDE_NTFS_3G := false
TW_EXCLUDE_ENCRYPTED_BACKUP := true
TW_SUPPORT_INPUT_VIBRATOR := false

# General GUI Theme Configurations (Official Light Weight Asset Profile)
TW_THEME := portrait_mdpi
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true

# ============================================
# PHASE 2 FIXES: TrustKernel TEE + FBE v2
# ============================================

# Disable QCOM hardware flag BEFORE crypto config (prevents QTI TEE probing)
BOARD_USES_QCOM_HARDWARE := false

# Core FBE Decryption Configuration (Android 13 + FBE v2)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_ENCRYPTION := true
TW_USE_FSCRYPT_POLICY := 2
TW_USE_FS_IOC_ADD_ENCRYPTION_KEY := true

# CRITICAL: Force Keymaster 4.1 to match vendor manifest
TW_FORCE_KEYMASTER_VERSION := 4.1
TW_USE_KEYMASTER_V4_1 := true
TW_CRYPTO_KEYMASTER_V2 := true

# Use software gatekeeper (TrustKernel gatekeeper requires TEE initialization)
TW_USE_SOFTWARE_GATEKEEPER := true

# Disable TEE probing to prevent TrustKernel TEE initialization conflicts
TW_IGNORE_TEE := true

# Fix vendor mount on dynamic partition devices
TW_MOUNT_VENDOR_AS_SYSTEM := true

# Auto-decrypt devices without lockscreen (default_password for FBE default encryption)
TW_DEFAULT_PASSWORD := "default_password"

# NVRAM support for MTK devices
TW_INCLUDE_NVRAM := true
TW_NVRAM_PATH := /mnt/vendor/nvdata

# Disable legacy hardware wrappers to clear libcryptfs_hw compilation error
TW_IGNORE_MISC_WIPE_DATA := true
