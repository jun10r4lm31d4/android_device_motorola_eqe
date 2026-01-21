# Configurações para habilitar ADB em user build
PRODUCT_PROPERTY_OVERRIDES += \
    ro.debuggable=1 \
    ro.secure=0 \
    ro.adb.secure=0

# Adicionar permissão para adbd
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/adbkey.pub:$(TARGET_COPY_OUT_PRODUCT)/etc/security/adb_keys

PRODUCT_PACKAGES += \
    adbd.rc \
    logcat_boot.sh
