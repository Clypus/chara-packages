# Chara Terminal UI Library
# Create beautiful terminal interfaces
#
# Usage:
#   import tui
#   call tui.clear()
#   call tui.title("My App")
#   set choice = call tui.menu(["Option 1", "Option 2", "Exit"])

import string

# ANSI color codes
set RESET = "\033[0m"
set BOLD = "\033[1m"
set RED = "\033[91m"
set GREEN = "\033[92m"
set YELLOW = "\033[93m"
set BLUE = "\033[94m"
set MAGENTA = "\033[95m"
set CYAN = "\033[96m"

# Clear screen
func clear() {
    print "\033[2J\033[H"
}

# Print with color
func color(text, col) {
    if col == "red" { return format("{}{}{}", RED, text, RESET) }
    if col == "green" { return format("{}{}{}", GREEN, text, RESET) }
    if col == "yellow" { return format("{}{}{}", YELLOW, text, RESET) }
    if col == "blue" { return format("{}{}{}", BLUE, text, RESET) }
    if col == "magenta" { return format("{}{}{}", MAGENTA, text, RESET) }
    if col == "cyan" { return format("{}{}{}", CYAN, text, RESET) }
    return text
}

# Bold text
func bold(text) {
    return format("{}{}{}", BOLD, text, RESET)
}

# Print a title with box
func title(text) {
    set slen = len(text)
    set top = "╔" + call string.repeat("═", slen + 2) + "╗"
    set mid = "║ " + text + " ║"
    set bot = "╚" + call string.repeat("═", slen + 2) + "╝"
    
    print call color(top, "cyan")
    print call color(mid, "cyan")
    print call color(bot, "cyan")
}

# Print a subtitle
func subtitle(text) {
    print call bold(call color("▶ " + text, "yellow"))
}

# Print info message
func info(text) {
    print call color("ℹ️  " + text, "blue")
}

# Print success message  
func success(text) {
    print call color("✅ " + text, "green")
}

# Print warning message
func warn(text) {
    print call color("⚠️  " + text, "yellow")
}

# Print error message
func error(text) {
    print call color("❌ " + text, "red")
}

# Print a progress bar
# progress(current, total)
func progress(current, total) {
    set pct = (current * 100) / total
    set filled = (current * 30) / total
    set empty = 30 - filled
    
    set bar = call string.repeat("█", filled) + call string.repeat("░", empty)
    print format("\r[{}] {}%", bar, pct)
}

# Print a horizontal line
func line() {
    print call color("─────────────────────────────────────────", "blue")
}

# Print a menu and return selection index
# Returns the index selected (0-based)
func menu(options) {
    print ""
    for i in range(len(options)) {
        set opt = options[i]
        print format("  [{}] {}", i + 1, opt)
    }
    print ""
    return 0  # Would need input() for real selection
}

# Print a table
# table(headers, rows)
func table(headers, rows) {
    # Print headers
    set header_str = "│"
    for h in headers {
        set header_str = header_str + format(" {:^15} │", h)
    }
    
    set sep = "├" + call string.repeat("─────────────────┼", len(headers) - 1) + "─────────────────┤"
    
    print "┌" + call string.repeat("─────────────────┬", len(headers) - 1) + "─────────────────┐"
    print call bold(header_str)
    print sep
    
    for row in rows {
        set row_str = "│"
        for cell in row {
            set row_str = row_str + format(" {:^15} │", cell)
        }
        print row_str
    }
    
    print "└" + call string.repeat("─────────────────┴", len(headers) - 1) + "─────────────────┘"
}

# Spinner animation (prints one frame)
func spinner(frame) {
    set frames = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"]
    set idx = frame % len(frames)
    print format("\r{} Loading...", frames[idx])
}

# Print a banner
func banner(text) {
    print ""
    print call color("  ╭──────────────────────────────────────╮", "magenta")
    print call color(format("  │  {:^36}  │", text), "magenta")
    print call color("  ╰──────────────────────────────────────╯", "magenta")
    print ""
}

# Demo function
func demo() {
    call clear()
    call title("Chara TUI Demo")
    print ""
    
    call info("This is an info message")
    call success("This is a success message")
    call warn("This is a warning")
    call error("This is an error")
    
    print ""
    call line()
    call subtitle("Menu Example")
    call menu(["Start Game", "Options", "Exit"])
    
    call line()
    call subtitle("Progress Bar")
    call progress(75, 100)
    print ""
    
    call banner("Thank you for using Chara TUI!")
}
