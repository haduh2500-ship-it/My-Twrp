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
# recovery.fstab must be at ramdisk root for TWRP to find it
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:recovery/root/etc/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt6765.rc:recovery/root/init.recovery.mt6765.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt8768.rc:recovery/root/init.recovery.mt8768.rc \
    $(LOCAL_PATH)/recovery/root/mtk-plpath-utils.rc:recovery/root/mtk-plpath-utils.rc \
    $(LOCAL_PATH)/recovery/root/snapuserd.rc:recovery/root/snapuserd.rc
