# OBS Studio — kayıt profili

Yerel **video kaydı** için ayarlanmış OBS profili (yayın yok).

## Profil: `Kayit-1440p60`

| Ayar | Değer |
|------|-------|
| Çıkış modu | Gelişmiş |
| Video kodlayıcı | NVIDIA NVENC HEVC (`obs_nvenc_hevc_tex`) |
| Oran kontrolü | CQP, CQ seviyesi **20** |
| Ön ayar / Ayarlama | P6 (Slower) / High Quality |
| Çoklu geçiş | Çift Geçiş (Tam Çözünürlük) |
| Çözünürlük / FPS | 2560x1440 / 60 |
| Kayıt biçimi | Hibrit MP4 (çökmeye dayanıklı + doğrudan .mp4) |
| Ses | 48 kHz / Stereo, FFmpeg AAC |

Donanım: Ryzen 7 9800X3D + RTX 4070 Ti SUPER. Kodlama GPU'nun NVENC çipinde yapılır.

## Geri yükleme (Windows)

1. OBS'i kapat.
2. `profiles/Kayit1440p60/` klasörünü şuraya kopyala:
   `%APPDATA%\obs-studio\basic\profiles\Kayit1440p60\`
   (tam yol: `C:\Users\<kullanıcı>\AppData\Roaming\obs-studio\basic\profiles\Kayit1440p60\`)
3. OBS'i aç → üst bardan **Profil → Kayit-1440p60** seç.

> Alternatif: OBS içinde **Profil → İçe Aktar** ile bu klasörü gösterebilirsin.

## Kapsam dışı (bilinçli)

- **Sahneler/kaynaklar** dahil değil — makineye özgü (monitör capture ID'leri, yerel dosya yolları).
- **`global.ini`** (dil, browser HW accel vb.) dahil değil — kuruluma özgü.
- Yayın (stream) ayarı / stream key yok; yayın hiç kurulmadı.
