# Chara Selfbot - Discord Self-Bot Bridge
# Node.js tabanlı discord.js-selfbot-v13 wrapper
#
# ⚠️ UYARI: Selfbot kullanımı Discord ToS'a aykırıdır!
#
# Kurulum:
#   cd ~/.chara/packages/chara-selfbot
#   npm install discord.js-selfbot-v13
#
# Kullanım:
#   import selfbot
#   call selfbot.login("USER_TOKEN")
#   call selfbot.send("channel_id", "Merhaba!")

import subprocess
import json
import io
import os

# Selfbot klasörü
set _selfbot_dir = call os.home() + "/.chara/packages/chara-selfbot"
set _bridge_script = _selfbot_dir + "/bridge.js"
set _token = ""
set _ready = false

# Kurulum kontrolü
func check_install() {
    set node_modules = _selfbot_dir + "/node_modules"
    if not call io.exists(node_modules) {
        print "❌ Selfbot kurulu değil!"
        print "   Kurulum için:"
        print format("   cd {}", _selfbot_dir)
        print "   npm install discord.js-selfbot-v13"
        return false
    }
    return true
}

# Login with user token
func login(token) {
    if not call check_install() {
        return false
    }
    
    set _token = token
    print "🔑 Token ayarlandı"
    set _ready = true
    return true
}

# Bridge'e komut gönder
func _bridge_call(action, params) {
    set args = [_bridge_script, action, _token]
    
    for p in params {
        call push(args, p)
    }
    
    set result = call subprocess.run("node", args)
    return result
}

# Mesaj gönder
func send(channel_id, message) {
    if not _ready {
        print "❌ Önce login() çağırın!"
        return false
    }
    
    set result = call _bridge_call("send", [channel_id, message])
    print format("📤 Mesaj gönderildi: {}", channel_id)
    return result
}

# Kullanıcı bilgisi al
func get_user() {
    if not _ready { return null }
    return call _bridge_call("user", [])
}

# Sunucu listesi
func get_guilds() {
    if not _ready { return null }
    return call _bridge_call("guilds", [])
}

# Kanal mesajlarını oku
func get_messages(channel_id, limit) {
    if not _ready { return null }
    return call _bridge_call("messages", [channel_id, limit])
}

# DM gönder
func dm(user_id, message) {
    if not _ready { return false }
    return call _bridge_call("dm", [user_id, message])
}

# Tepki ekle
func react(channel_id, message_id, emoji) {
    if not _ready { return false }
    return call _bridge_call("react", [channel_id, message_id, emoji])
}

# Mesaj sil
func delete_message(channel_id, message_id) {
    if not _ready { return false }
    return call _bridge_call("delete", [channel_id, message_id])
}

# Mesaj düzenle
func edit(channel_id, message_id, new_content) {
    if not _ready { return false }
    return call _bridge_call("edit", [channel_id, message_id, new_content])
}

# Durum değiştir
func set_status(status, activity_type, activity_name) {
    # status: online, idle, dnd, invisible
    # activity_type: PLAYING, STREAMING, LISTENING, WATCHING
    if not _ready { return false }
    return call _bridge_call("status", [status, activity_type, activity_name])
}

# Nickname değiştir
func set_nickname(guild_id, nickname) {
    if not _ready { return false }
    return call _bridge_call("nickname", [guild_id, nickname])
}

# DM kanalı aç
func open_dm(user_id) {
    if not _ready { return null }
    return call _bridge_call("opendm", [user_id])
}

# Bot'u başlat (sürekli çalışma)
func run(on_message_handler) {
    if not _ready {
        print "❌ Önce login() çağırın!"
        return
    }
    
    print "🚀 Selfbot başlatılıyor..."
    print "   Ctrl+C ile durdurun"
    
    # Background process olarak çalıştır
    call subprocess.run("node", [_bridge_script, "run", _token])
}

# Demo
func demo() {
    print "🤖 Chara Selfbot Demo"
    print ""
    print "Kullanım:"
    print "  import selfbot"
    print "  call selfbot.login(\"YOUR_USER_TOKEN\")"
    print "  call selfbot.send(\"123456789\", \"Merhaba!\")"
    print ""
    print "⚠️  Selfbot Discord ToS'a aykırıdır!"
}
