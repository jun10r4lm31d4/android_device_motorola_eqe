#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Boot animation
TARGET_SCREEN_HEIGHT := 2712
TARGET_SCREEN_WIDTH := 1220

# Screen
TARGET_SCREEN_DENSITY := 400

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# API
BOARD_SHIPPING_API_LEVEL := 33
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Inherit from motorola sm7550-common
$(call inherit-product, device/motorola/sm7550-common/common.mk)

# Overlay
PRODUCT_PACKAGES += \
    ApertureResDevice \
    DeviceAsWebcamResDevice \
    FrameworksResDevice \
    LineageSystemUIDevice \
    ProductFrameworksResDevice \
    RegulatoryInfoOverlayDevice \
    RegulatoryInfoOverlayDeviceSB \
    SettingsResDevice \
    SystemUIResDevice \
    SecureElementOverlayDevice

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/sku_crow/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_crow/audio_effects.xml \
    $(LOCAL_PATH)/audio/sku_crow/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_crow/audio_effects.conf \
    $(LOCAL_PATH)/audio/sku_crow/mixer_paths_crow_idp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_crow/mixer_paths_crow_idp.xml \
    $(LOCAL_PATH)/audio/sku_crow/resourcemanager_crow_idp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_crow/resourcemanager_crow_idp.xml \
    $(LOCAL_PATH)/audio/sku_crow_qssi/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/sku_crow_qssi/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_crow_qssi/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/audio_ext_spkr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_ext_spkr.conf \
    $(LOCAL_PATH)/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/audio/microphone_characteristics.xml:$(TARGET_COPY_OUT_VENDOR)/etc/microphone_characteristics.xml \
    $(LOCAL_PATH)/audio/usecaseKvManager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usecaseKvManager.xml \

# Camera
PRODUCT_PACKAGES += \
    libgui_shim_vendor

# Dex-pre-opt exclusions
$(call add-product-dex-preopt-module-config,MotoSignatureApp,disable)

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.moto_sm7550_fod

# Init
PRODUCT_PACKAGES += \
    init.mmi.overlay.rc \
    init.vendor.st21nfc.rc

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/goodix_ts.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/goodix_ts.kl

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    Tag \
    nfc_nci.st21nfc.default

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml

# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.powershare-service.default

$(call soong_config_set,lineage_powershare,powershare_path,/sys/class/power_supply/wireless/device/tx_mode)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Inherit from vendor blobs
$(call inherit-product, vendor/motorola/eqe/eqe-vendor.mk)
