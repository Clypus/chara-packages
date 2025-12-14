# Chara 2D Game Framework
# Simple 2D game development library for Chara
#
# Usage:
#   import game
#   call game.init(800, 600, "My Game")
#   call game.sprite("player", 100, 100)
#   call game.run()

import gui
import time

# Game state
set _window = null
set _sprites = []
set _running = false
set _fps = 60
set _width = 800
set _height = 600

# Initialize game window
func init(width, height, title) {
    set _width = width
    set _height = height
    
    call gui.init()
    set _window = call gui.createWindow(title, width, height)
    set _running = true
    
    print format("🎮 Game initialized: {}x{}", width, height)
}

# Create a sprite
# Returns sprite ID
func sprite(name, x, y) {
    set spr = {
        "name": name,
        "x": x,
        "y": y,
        "width": 32,
        "height": 32,
        "visible": true,
        "velocity_x": 0,
        "velocity_y": 0
    }
    call push(_sprites, spr)
    return len(_sprites) - 1
}

# Move sprite
func move(sprite_id, dx, dy) {
    set spr = _sprites[sprite_id]
    set spr["x"] = spr["x"] + dx
    set spr["y"] = spr["y"] + dy
}

# Set sprite position
func set_pos(sprite_id, x, y) {
    set spr = _sprites[sprite_id]
    set spr["x"] = x
    set spr["y"] = y
}

# Set sprite velocity
func set_velocity(sprite_id, vx, vy) {
    set spr = _sprites[sprite_id]
    set spr["velocity_x"] = vx
    set spr["velocity_y"] = vy
}

# Check collision between two sprites
func collides(id1, id2) {
    set s1 = _sprites[id1]
    set s2 = _sprites[id2]
    
    set overlap_x = s1["x"] < s2["x"] + s2["width"] and s1["x"] + s1["width"] > s2["x"]
    set overlap_y = s1["y"] < s2["y"] + s2["height"] and s1["y"] + s1["height"] > s2["y"]
    
    return overlap_x and overlap_y
}

# Draw rectangle
func rect(x, y, w, h, r, g, b) {
    call gui.setColor(_window, r, g, b)
    call gui.drawRect(_window, x, y, w, h)
}

# Clear screen with color
func clear(r, g, b) {
    call gui.setColor(_window, r, g, b)
    call gui.clear(_window)
}

# Present/flip screen
func present() {
    call gui.present(_window)
}

# Set FPS
func set_fps(fps) {
    set _fps = fps
}

# Check if key is pressed (simplified)
func key_pressed(key) {
    # Would need input handling
    return false
}

# Random number helper
func random_int(min, max) {
    set rnd = random.random
    return min + call rnd() % (max - min + 1)
}

# Distance between two points
func distance(x1, y1, x2, y2) {
    set dx = x2 - x1
    set dy = y2 - y1
    return call math.sqrt(dx * dx + dy * dy)
}

# Update all sprites (apply velocity)
func update_sprites() {
    for spr in _sprites {
        set spr["x"] = spr["x"] + spr["velocity_x"]
        set spr["y"] = spr["y"] + spr["velocity_y"]
    }
}

# Draw all sprites
func draw_sprites() {
    for spr in _sprites {
        if spr["visible"] {
            call rect(spr["x"], spr["y"], spr["width"], spr["height"], 255, 255, 255)
        }
    }
}

# Main game loop helper
func loop(update_func, draw_func) {
    set delay = 1000 / _fps
    
    while _running {
        # Update
        call update_sprites()
        
        # Draw
        call clear(0, 0, 0)
        call draw_sprites()
        call present()
        
        # Delay
        call gui.delay(delay)
        
        # Check for quit event
        set evt = call gui.pollEvent(_window)
        if evt == "quit" {
            set _running = false
        }
    }
}

# Stop game
func quit() {
    set _running = false
    call gui.destroy(_window)
}

# Example: Simple bouncing ball
func example() {
    call init(800, 600, "Bouncing Ball")
    
    set ball = call sprite("ball", 400, 300)
    call set_velocity(ball, 5, 3)
    
    # Game loop would go here
    print "🎮 Game example created!"
    print "   Ball at (400, 300) with velocity (5, 3)"
}
