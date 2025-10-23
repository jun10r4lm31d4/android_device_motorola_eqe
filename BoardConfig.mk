#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/eqe

# Inherit from motorola sm7550-common
include device/motorola/sm7550-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := eqe

# Display
TARGET_SCREEN_DENSITY := 450

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/device_framework_matrix.xml
ODM_MANIFEST_SKUS += dn dne
ODM_MANIFEST_DN_FILES := $(DEVICE_PATH)/manifest_dn.xml
ODM_MANIFEST_DNE_FILES := $(DEVICE_PATH)/manifest_dne.xml

# Kernel
TARGET_KERNEL_CONFIG += \
	vendor/ext_config/moto-kalama-eqe.config

# Partitions
BOARD_MOT_DP_GROUP_SIZE := 10867441664 # ( BOARD_SUPER_PARTITION_SIZE - 4MB )
BOARD_SUPER_PARTITION_SIZE := 10871635968

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Security
BOOT_SECURITY_PATCH := 2025-05-01
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)

# Verified Boot
BOARD_AVB_ROLLBACK_INDEX := 15
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(BOARD_AVB_ROLLBACK_INDEX)

# inherit from the proprietary version
include vendor/motorola/eqe/BoardConfigVendor.mk
