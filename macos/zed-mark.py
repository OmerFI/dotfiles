#!/usr/bin/env python3
"""Uzantısız metin dosyalarını Zed'de açılır hale getirir.

macOS uzantısız dosyaları `public.data` sayar ve bu tipi yerleşik TextEdit'e
kilitler; uzantı eklemeden tip seviyesinde başka uygulamaya devretmeye izin
vermez. Çözüm: dosyaya adını değiştirmeden eski Mac tip kodu 'TEXT' damgalamak.
Bunu yazınca macOS dosyayı düz metin (traditional-mac-plain-text) olarak tanır;
o tipin varsayılanını Zed yaptıysan (set-zed-as-text-editor.swift) dosya artık
çift tıklamayla Zed'de açılır.

Mevcut FinderInfo baytlarını (renk etiketi vb.) korur, ikili dosyaları atlar.

    uv run zed-mark.py "dosya1" "dosya2" ...
"""
import binascii
import subprocess
import sys

ATTR = "com.apple.FinderInfo"
TEXT = bytes([0x54, 0x45, 0x58, 0x54])  # 'TEXT' OSType


def read_finderinfo(path: str) -> bytearray:
    r = subprocess.run(["xattr", "-px", ATTR, path], capture_output=True, text=True)
    if r.returncode != 0:
        return bytearray(32)
    raw = bytes.fromhex(r.stdout.replace("\n", "").replace(" ", ""))
    return bytearray(raw.ljust(32, b"\0")[:32])


def is_text(path: str) -> bool:
    # JSON/XML/kaynak kodu da metindir; en genel kontrol mime-encoding:
    # ikili dosyalar "binary" döner, metin dosyaları us-ascii/utf-8 vb.
    r = subprocess.run(["file", "-b", "--mime-encoding", path], capture_output=True, text=True)
    return r.stdout.strip() != "binary"


for path in sys.argv[1:]:
    if not is_text(path):
        print(f"atlandı (metin değil): {path}")
        continue
    fi = read_finderinfo(path)
    fi[0:4] = TEXT
    subprocess.run(["xattr", "-wx", ATTR, binascii.hexlify(bytes(fi)).decode(), path], check=True)
    print(f"işaretlendi: {path}")
