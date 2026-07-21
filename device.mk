# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/herofun/BH502G

# A/B Configurations
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot Control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    bootctrl.mt6765 \
    libgptutils \
    libz \
    libcutils

# Dynamic Target Update Systems
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# Decryption Service Libraries
PRODUCT_PACKAGES += \
    libxml2 \
    libc++ \
    libcrypto

# Recovery File Injections
# ONLY files that TWRP does NOT generate automatically
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:recovery/root/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt6765.rc:recovery/root/init.recovery.mt6765.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt8768.rc:recovery/root/init.recovery.mt8768.rc \
    $(LOCAL_PATH)/recovery/root/mtk-plpath-utils.rc:recovery/root/mtk-plpath-utils.rc \
    $(LOCAL_PATH)/recovery/root/snapuserd.rc:recovery/root/snapuserd.rc

# First stage ramdisk fstab files — TWRP does NOT generate these
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/first_stage_ramdisk/fstab.mt6765:recovery/root/first_stage_ramdisk/fstab.mt6765 \
    $(LOCAL_PATH)/recovery/root/first_stage_ramdisk/fstab.mt8768:recovery/root/first_stage_ramdisk/fstab.mt8768
