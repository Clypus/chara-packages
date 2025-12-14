# Chara Utils - General Utilities
# Common utility functions for Chara
#
# Usage:
#   import utils
#   set slug = call utils.slugify("Hello World!")
#   call utils.retry(my_func, 3)

import string
import time
import random

# Generate a slug from text
# "Hello World!" -> "hello-world"
func slugify(text) {
    set slow = string.lower
    set result = call slow(text)
    
    # Replace spaces with dashes
    set srep = string.replace
    set result = call srep(result, " ", "-")
    set result = call srep(result, "!", "")
    set result = call srep(result, "?", "")
    set result = call srep(result, "'", "")
    
    return result
}

# Truncate text with ellipsis
func truncate(text, max_len) {
    if len(text) <= max_len {
        return text
    }
    set sslice = string.slice
    return call sslice(text, 0, max_len - 3) + "..."
}

# Capitalize first letter
func capitalize(text) {
    if len(text) == 0 { return text }
    set schar = string.charAt
    set sslice = string.slice
    set sup = string.upper
    set first = call sup(call schar(text, 0))
    return first + call sslice(text, 1)
}

# Title case
func titlecase(text) {
    set ssplit = string.split
    set words = call ssplit(text, " ")
    set result = []
    for word in words {
        call push(result, call capitalize(word))
    }
    set sjoin = string.join
    return call sjoin(result, " ")
}

# Check if string is numeric
func is_numeric(text) {
    for i in range(len(text)) {
        set schar = string.charAt
        set c = call schar(text, i)
        if c < "0" or c > "9" {
            if c != "." and c != "-" {
                return false
            }
        }
    }
    return true
}

# Retry a function n times
func retry(func_result, max_retries) {
    set attempts = 0
    while attempts < max_retries {
        if func_result != null {
            return func_result
        }
        set attempts = attempts + 1
        print format("Retry {}/{}", attempts, max_retries)
        call time.sleep(1)
    }
    return null
}

# Debounce - delay execution
func debounce(seconds) {
    call time.sleep(seconds)
}

# Generate random string
func random_string(length) {
    set chars = "abcdefghijklmnopqrstuvwxyz0123456789"
    set result = ""
    for i in range(length) {
        set rnd = random.random
        set idx = call rnd() % len(chars)
        set schar = string.charAt
        set result = result + call schar(chars, idx)
    }
    return result
}

# Generate UUID-like string
func uuid() {
    set parts = []
    call push(parts, call random_string(8))
    call push(parts, call random_string(4))
    call push(parts, call random_string(4))
    call push(parts, call random_string(4))
    call push(parts, call random_string(12))
    set sjoin = string.join
    return call sjoin(parts, "-")
}

# Clamp value between min and max
func clamp(value, min_val, max_val) {
    if value < min_val { return min_val }
    if value > max_val { return max_val }
    return value
}

# Linear interpolation
func lerp(a, b, t) {
    return a + (b - a) * t
}

# Map value from one range to another
func map_range(value, in_min, in_max, out_min, out_max) {
    return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
}

# Deep clone an object (simplified)
func clone(obj) {
    # For now, just create a copy
    if type(obj) == "list" {
        set result = []
        for item in obj {
            call push(result, item)
        }
        return result
    }
    return obj
}

# Flatten nested list
func flatten(nested) {
    set result = []
    for item in nested {
        if type(item) == "list" {
            for sub in item {
                call push(result, sub)
            }
        } else {
            call push(result, item)
        }
    }
    return result
}

# Remove duplicates from list
func unique(list) {
    set seen = {}
    set result = []
    for item in list {
        if seen[item] == null {
            set seen[item] = true
            call push(result, item)
        }
    }
    return result
}

# Chunk list into smaller parts
func chunk(list, size) {
    set result = []
    set current = []
    
    for item in list {
        call push(current, item)
        if len(current) >= size {
            call push(result, current)
            set current = []
        }
    }
    
    if len(current) > 0 {
        call push(result, current)
    }
    
    return result
}

# Measure execution time
func timer() {
    return {
        "start": call time.now(),
        "end": 0
    }
}

func timer_stop(t) {
    set t["end"] = call time.now()
    return t["end"] - t["start"]
}

# Demo
func demo() {
    print "🔧 Chara Utils Demo"
    print ""
    
    print format("slugify('Hello World!'): {}", call slugify("Hello World!"))
    print format("truncate('Long text here', 10): {}", call truncate("Long text here", 10))
    print format("titlecase('hello world'): {}", call titlecase("hello world"))
    print format("random_string(8): {}", call random_string(8))
    print format("uuid(): {}", call uuid())
    print format("clamp(15, 0, 10): {}", call clamp(15, 0, 10))
    print format("lerp(0, 100, 0.5): {}", call lerp(0, 100, 0.5))
}
