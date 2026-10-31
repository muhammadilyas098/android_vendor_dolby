#!/usr/bin/env python3
"""Sisipkan effect Dolby (dap, gamedap, vqe) ke audio_effects.xml. Idempotent.
Pemakaian: patch_audio_effects.py <input.xml> <output.xml>"""
import re
import sys

LIBS = [("dap", "libswdap.so"), ("gamedap", "libswgamedap.so"), ("vqe", "libswvqe.so")]
EFFECTS = [
    ("dap", "dap", "9d4921da-8225-4f29-aefa-39537a04bcaa"),
    ("gamedap", "gamedap", "3783c334-d3a0-4d13-874f-0032e5fb80e2"),
    ("vqe", "vqe", "64a0f614-7fa4-48b8-b081-d59dc954616f"),
]


def strip_old(text):
    # buang entry lama dengan nama/uuid yang sama supaya tidak dobel
    for name, _ in LIBS:
        text = re.sub(r'[ \t]*<library\s+name="%s"[^>]*/>[ \t]*\n?' % name, "", text)
    for name, _, uuid in EFFECTS:
        text = re.sub(r'[ \t]*<effect\s+[^>]*(?:name="%s"|uuid="%s")[^>]*/>[ \t]*\n?' % (name, uuid), "", text, flags=re.I)
    return text


def insert_after(text, tag, lines):
    m = re.search(r"^([ \t]*)<%s>[ \t]*\n" % tag, text, flags=re.M)
    if not m:
        sys.exit("patch_audio_effects: tag <%s> tidak ditemukan" % tag)
    ind = m.group(1) + "    "
    block = "".join(ind + l + "\n" for l in lines)
    return text[: m.end()] + block + text[m.end():]


def main(src, dst):
    text = strip_old(open(src, encoding="utf-8").read())
    text = insert_after(text, "libraries", ['<library name="%s" path="%s"/>' % l for l in LIBS])
    text = insert_after(text, "effects", ['<effect name="%s" library="%s" uuid="%s"/>' % e for e in EFFECTS])
    open(dst, "w", encoding="utf-8").write(text)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(*sys.argv[1:])
