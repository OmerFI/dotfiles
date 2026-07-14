// Zed'i düz metin dosya tiplerinin varsayılan uygulaması yapar.
// Uzantısız dosyalar için zed-mark.py ile birlikte çalışır (bkz. README.md).
// Tek sefer çalıştırılır, idempotenttir. Başka bir editör için editorBundleID'yi değiştir.
//
//   swift set-zed-as-text-editor.swift
import CoreServices
import Foundation

let editorBundleID = "dev.zed.Zed"
let types = [
    "com.apple.traditional-mac-plain-text",  // zed-mark.py'nin damgaladığı tip — uzantısız dosyalar için ZORUNLU
    "public.plain-text",                     // .txt vb. tüm düz metin (opsiyonel)
    "public.text",                           // opsiyonel
]
for t in types {
    let status = LSSetDefaultRoleHandlerForContentType(t as CFString, .all, editorBundleID as CFString)
    print("\(t) -> \(editorBundleID)  (status \(status))")
}
