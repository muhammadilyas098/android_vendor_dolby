# vendor/moto/dolby

Dolby Atmos (DAX3) dari modul Magisk Moto G52 (rhode). Blob/app milik Dolby & Motorola.

Pakai di device.mk:
    $(call inherit-product, vendor/moto/dolby/dolby.mk)

audio_effects.xml: pakai tools/patch_audio_effects.py (otomatis lewat audio_effects/Android.bp.sample,
lihat komentar di dalamnya) atau tempel manual entry dap, gamedap, vqe.

libstagefright_foundation bawaan modul sudah diganti nama jadi libstagefright_fdtn_dolby
(NEEDED di blob juga dipatch), jadi tidak butuh libstagefright_foundation-v33 dari tree.
