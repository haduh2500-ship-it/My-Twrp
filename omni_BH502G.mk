# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from core build configurations. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from BH502G device configuration
$(call inherit-product, device/herofun/BH502G/device.mk)

PRODUCT_DEVICE := BH502G
PRODUCT_NAME := omni_BH502G
PRODUCT_BRAND := HEROFUN
PRODUCT_MODEL := BH502G
PRODUCT_MANUFACTURER := herofun

PRODUCT_GMS_CLIENTID_BASE := android-joyar

# Unified Android 13 Identity Properties (Critical for Keystore Validation alignment)
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="BH502G-user 13 TP1A.220624.014 1724242012 release-keys"

BUILD_FINGERPRINT := HEROFUN/BH502G/BH502G:13/TP1A.220624.014/1724242012:user/release-keys
