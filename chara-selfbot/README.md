# 🤖 Chara Selfbot

Discord selfbot bridge using discord.js-selfbot-v13 for Chara Lang.

## ⚠️ UYARI

Selfbot kullanımı **Discord Hizmet Şartları'na aykırıdır!**
Hesabınız kalıcı olarak banlanabilir. Risk size aittir.

## 📦 Kurulum

```bash
# Paketi kur
cpm install chara-selfbot

# Node.js bağımlılıklarını kur
cd ~/.chara/packages/chara-selfbot
npm install
```

## 🚀 Kullanım

```chara
import selfbot

# Login (kullanıcı token'ı ile)
call selfbot.login("YOUR_USER_TOKEN")

# Mesaj gönder
call selfbot.send("CHANNEL_ID", "Merhaba!")

# DM gönder
call selfbot.dm("USER_ID", "Selam!")

# Tepki ekle
call selfbot.react("CHANNEL_ID", "MESSAGE_ID", "👍")

# Durum değiştir
call selfbot.set_status("dnd", "PLAYING", "Chara Lang")

# Kullanıcı bilgisi
set user = call selfbot.get_user()
print user
```

## 📋 Fonksiyonlar

| Fonksiyon | Açıklama |
|-----------|----------|
| `login(token)` | Token ile giriş |
| `send(channel_id, message)` | Kanal'a mesaj gönder |
| `dm(user_id, message)` | DM gönder |
| `react(channel, msg, emoji)` | Tepki ekle |
| `delete_message(ch, msg)` | Mesaj sil |
| `edit(ch, msg, content)` | Mesaj düzenle |
| `set_status(status, type, name)` | Durum değiştir |
| `set_nickname(guild, nick)` | Nickname değiştir |
| `get_user()` | Kullanıcı bilgisi |
| `get_guilds()` | Sunucu listesi |
| `get_messages(ch, limit)` | Mesajları oku |

## 🔑 Token Nasıl Alınır?

1. Discord web'de giriş yap
2. F12 (Developer Tools)
3. Console sekmesi
4. Şunu yaz:
```javascript
(webpackChunkdiscord_app.push([[''],{},e=>{m=[];for(let c in e.c)m.push(e.c[c])}]),m).find(m=>m?.exports?.default?.getToken).exports.default.getToken()
```

## 📁 Dosya Yapısı

```
chara-selfbot/
├── selfbot.ch     # Chara modülü
├── bridge.js      # Node.js köprüsü
├── package.json   # NPM bağımlılıkları
└── README.md      # Bu dosya
```

## 🦎 Örnek

```chara
import selfbot
import time

# Login
call selfbot.login("TOKEN_HERE")

# Spam protection ile mesaj gönder
set channels = ["123", "456", "789"]

for ch in channels {
    call selfbot.send(ch, "Merhaba herkese!")
    call time.sleep(2)  # 2 saniye bekle
}

print "Tamamlandı!"
```

---

⚠️ **UYARI**: Bu paket eğitim amaçlıdır. Kötüye kullanımdan sorumlu değiliz.

🦎 https://github.com/Clypus/chara-packages
