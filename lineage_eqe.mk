#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from eqe device
$(call inherit-product, device/motorola/eqe/device.mk)

TARGET_ENABLE_BLUR := true
TARGET_DISABLE_MATLOG := true
TARGET_EXCLUDES_AUDIOFX := true

PRODUCT_DEVICE := eqe
PRODUCT_NAME := lineage_eqe
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola edge 50 pro
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="eqe_g-user 15 V1UM35H.10-67-9 ce05b2-7ae82e release-keys" \
    BuildFingerprint=motorola/eqe_g/eqe:15/V1UM35H.10-67-9/ce05b2-7ae82e:user/release-keys \
    DeviceName=eqe \
    DeviceProduct=eqe_g \
    SystemDevice=eqe \
    SystemName=eqe_g
