#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.extract import extract_fns_user_type
from extract_utils.extract_star import extract_star_firmware
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/motorola/eqe',
    'hardware/motorola',
    'hardware/qcom-caf/sm8550',
    'vendor/motorola/sm7550-common',
    'vendor/qcom/opensource/commonsys-intf/display',
]

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (): lib_fixup_vendor_suffix,
    (
        'libar-acdb',
        'libar-gsl',
        'liblx-osal',
        'libats',
        'libagmclient',
        'libpalclient',
        'vendor.qti.hardware.AGMIPC@1.0-impl',
    ): lib_fixup_remove,
}

blob_fixups: blob_fixups_user_type = {
    ('vendor/lib/libmot_chi_desktop_helper.so', 'vendor/lib64/libmot_chi_desktop_helper.so'): blob_fixup()
        .add_needed('libgui_shim_vendor.so'),
    'vendor/lib64/nfc_nci.nqx.default.hw.so': blob_fixup()
        .add_needed('libbase_shim.so'),
}  # fmt: skip

extract_fns: extract_fns_user_type = {
    r'(bootloader|radio)\.img': extract_star_firmware,
}

module = ExtractUtilsModule(
    'eqe',
    'motorola',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    extract_fns=extract_fns,
    add_firmware_proprietary_file=True,
    add_generated_carriersettings=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(module, 'sm7550-common', module.vendor)
    utils.run()