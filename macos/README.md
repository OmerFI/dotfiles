# macOS

Uzantısız metin dosyalarını (indirilen `Untitled` dosyaları, `Makefile`, log dökümleri vb.) çift tıklayınca TextEdit yerine Zed'de açmak için.

## Sorun

macOS bir dosyanın tipini önce uzantısından belirler. Uzantı yoksa ve dosyada başka bir tip metadata'sı da yoksa dosya `public.data` sayılır ve sistem bu tipi kendi yerleşik TextEdit yönlendirmesine kilitler. Bu tipe başka bir uygulama atamaya ne eski (`LSSetDefaultRoleHandlerForContentType`, hata −50) ne de yeni (`NSWorkspace.setDefaultApplication`) API izin verir; dosya-başına "her zaman şununla aç" bağlaması da yok sayılır. Yani uzantı eklemeden, tip seviyesinden bu dosyaları başka bir uygulamaya yönlendirmenin doğrudan bir yolu yoktur.

## Çözüm

Uzantı eklemeden işe yarayan tek yol, dosyaya adını değiştirmeden eski Mac **tip kodu** `'TEXT'` damgalamaktır. Bu, dosyanın `com.apple.FinderInfo` metadata'sına yazılan görünmez bir işarettir; macOS'un düz metin tanımı (`public.plain-text`) `com.apple.ostype = TEXT` içerdiği için, işaretlenen dosya artık düz metin (`com.apple.traditional-mac-plain-text`) olarak sınıflanır. Sonra bu tipin varsayılan uygulamasını Zed yaparız.

**1. Tek seferlik — Zed'i düz metin tiplerinin varsayılanı yap:**

```bash
swift set-zed-as-text-editor.swift
```

**2. Her uzantısız dosya için — `'TEXT'` tip kodunu damgala:**

```bash
uv run zed-mark.py "~/Downloads/Untitled (5)" "~/Downloads/Untitled (6)"
```

`zed-mark.py` mevcut FinderInfo baytlarını (renk etiketi vb.) korur ve ikili dosyaları atlar. Uzantısı olan dosyalar (`.txt`, `.json` …) zaten 1. adımdaki ayar sayesinde Zed'de açılır; bu betiğe yalnızca uzantısız dosyalar için ihtiyaç var.

## Sınır

Her uzantısız dosyanın bir kez damgalanması gerekir. Bunun etrafından dolaşılamaz: hiç metadata'sı olmayan çıplak bir dosyayı macOS ilkesel olarak TextEdit'e verir, tip seviyesinde toplu bir yönlendirme kabul etmez.

## Başka editör

Zed yerine başka bir uygulama istersen `set-zed-as-text-editor.swift` içindeki `editorBundleID` değerini değiştir (uygulamanın bundle id'si: `mdls -name kMDItemCFBundleIdentifier /Applications/<Uygulama>.app`).
