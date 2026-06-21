# Firefox

Firefox'ta karşılaşılan siteye-özgü sorunlar ve kalıcı çözümleri.

## 1. `intl.accept_languages` bozuk → Xbox / Microsoft girişi başarısız

**Belirti:** `xbox.com`'da Microsoft hesabıyla giriş başarılı oluyor ama son
adımda (`xsts.auth.xboxlive.com/xsts/authorize`) **HTTP 500** alıp girişsiz
geri atıyor. Chrome'da aynı hesap sorunsuz giriyor.

**Neden:** Firefox'un `intl.accept_languages` pref'i, geçerli bir dil listesi
yerine çözülmemiş `chrome://global/locale/intl.properties` pointer'ına
literal olarak sabitlenmiş → `Accept-Language` başlığı bu geçersiz string
olarak gidiyor → XSTS ayrıştıramayıp 500 dönüyor. Bilinen bir **Firefox Sync**
bug'ı: Sync, yerelleştirilmiş pref'i yanlış metotla okuyup (`getComplexValue`)
literal pointer'ı tüm senkron cihazlara yayıyor. Bu yüzden profil sıfırlama /
Refresh işe yaramaz — Sync geri yükler.
Bugzilla: 654099, 438031, 652934.

**Çözüm:** `about:config` → `intl.accept_languages` değerini şu yap:

```
tr-TR, tr, en-US, en
```

(veya Ayarlar → Genel → Dil → tercih edilen dilleri seç). Firefox'u yeniden
başlat. Doğru değeri Firefox içinden yazınca Sync de düzgün değeri yayar.

## 2. Unity Asset Store → bozuk Service Worker

Bkz. `ublock-my-filters.txt` (dosyanın başındaki yorumlar nedeni açıklıyor).
