# Dolby Atmos (DAX3). Pakai: $(call inherit-product, vendor/moto/dolby/dolby.mk)

DOLBY_PATH := vendor/moto/dolby

PRODUCT_SOONG_NAMESPACES += $(DOLBY_PATH)

# Packages
PRODUCT_PACKAGES += \
    MotoDolbyDax3 \
    daxService \
    libdapparamstorage \
    libdeccfg \
    libdlbdsservice \
    libsqlite_dolby \
    libstagefright_fdtn_dolby \
    libstagefright_soft_ac4dec \
    libstagefright_soft_ddpdec \
    libstagefrightdolby \
    libswdap \
    libswgamedap \
    libswvqe \
    vendor.dolby.hardware.dms@2.0 \
    vendor.dolby.hardware.dms@2.0-impl \
    vendor.dolby.hardware.dms@2.0-service

# Vendor: config, init, VINTF
PRODUCT_COPY_FILES += \
    $(DOLBY_PATH)/proprietary/vendor/etc/dolby/dax-default.xml:$(TARGET_COPY_OUT_VENDOR)/etc/dolby/dax-default.xml \
    $(DOLBY_PATH)/proprietary/vendor/etc/media_codecs_dolby_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_dolby_audio.xml \
    $(DOLBY_PATH)/proprietary/vendor/etc/init/vendor.dolby.hardware.dms@2.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.dolby.hardware.dms@2.0-service.rc \
    $(DOLBY_PATH)/configs/vintf/vendor.dolby.hardware.dms@2.0-service.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/vendor.dolby.hardware.dms@2.0-service.xml

# System_ext: allowlist priv-app, feature, sysconfig, default-permissions
PRODUCT_COPY_FILES += \
    $(DOLBY_PATH)/configs/permissions/privapp-permissions-dolby.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-dolby.xml \
    $(DOLBY_PATH)/configs/permissions/com.motorola.software.dolbyui.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/com.motorola.software.dolbyui.xml \
    $(DOLBY_PATH)/configs/sysconfig/config-com.dolby.daxservice.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/config-com.dolby.daxservice.xml \
    $(DOLBY_PATH)/configs/sysconfig/config-com.motorola.dolby.dolbyui.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/config-com.motorola.dolby.dolbyui.xml \
    $(DOLBY_PATH)/configs/default-permissions/default-com.dolby.daxservice.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/default-permissions/default-com.dolby.daxservice.xml \
    $(DOLBY_PATH)/configs/default-permissions/default-com.motorola.dolby.dolbyui.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/default-permissions/default-com.motorola.dolby.dolbyui.xml

# SEPolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DOLBY_PATH)/sepolicy/vendor
ifneq ($(filter mt%,$(TARGET_BOARD_PLATFORM)),)
BOARD_VENDOR_SEPOLICY_DIRS += $(DOLBY_PATH)/sepolicy/mtk
endif

# Properties (nilai sama dengan service.sh modul)
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.audio_fx.current=dolby \
    ro.vendor.audio.dolby.dax.support=true \
    ro.vendor.dolby.dax.version=DAX3_3.6.0.12_r1 \
    ro.dolby.mod_uuid=false \
    ro.dolby.music_stream=false \
    vendor.audio.dolby.ds2.enabled=true \
    vendor.audio.dolby.ds2.hardbypass=true

PRODUCT_PRODUCT_PROPERTIES += \
    ro.audio.monitorWindowRotation=true

# Jangan sertakan AudioFX bawaan Lineage
TARGET_EXCLUDES_AUDIOFX := true
