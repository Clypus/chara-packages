# Chara Web Framework
# A simple HTTP server and routing library for Chara
#
# Usage:
#   import web
#   set app = call web.create()
#   call web.route(app, "/", "Hello World!")
#   call web.run(app, 8080)

import http
import io
import json

# Create a new web application
# Returns an app object (map)
func create() {
    return {
        "routes": {},
        "middleware": [],
        "static": null
    }
}

# Add a route
# route(app, path, handler)
# handler can be string or function name
func route(app, path, handler) {
    set app["routes"][path] = handler
}

# Serve static files from directory
# static(app, dir)
func static_dir(app, dir) {
    set app["static"] = dir
}

# Add middleware
# middleware(app, func_name)  
func middleware(app, func_name) {
    call push(app["middleware"], func_name)
}

# Simple HTML response helper
# html(content) -> formatted HTML
func html(content) {
    return format("<!DOCTYPE html><html><head><meta charset='utf-8'><title>Chara Web</title></head><body>{}</body></html>", content)
}

# JSON response helper
# json_response(data) -> JSON string
func json_response(data) {
    set jstr = json.stringify
    return call jstr(data)
}

# Template rendering (simple)
# render(template, vars) -> string
func render(template, vars) {
    set result = template
    for key in vars {
        set placeholder = format("{{{}}}", key)
        set value = vars[key]
        # Simple replace
        set sreplace = string.replace
        set result = call sreplace(result, placeholder, value)
    }
    return result
}

# Redirect helper
func redirect(location) {
    return {
        "status": 302,
        "headers": {"Location": location},
        "body": ""
    }
}

# Parse query string
# parse_query("a=1&b=2") -> {"a": "1", "b": "2"}
func parse_query(query) {
    set result = {}
    set ssplit = string.split
    set parts = call ssplit(query, "&")
    for part in parts {
        set kv = call ssplit(part, "=")
        if len(kv) == 2 {
            set result[kv[0]] = kv[1]
        }
    }
    return result
}

# Cookie helper
func set_cookie(name, value, max_age) {
    return format("{}={}; Max-Age={}; Path=/", name, value, max_age)
}

# Run the server (simplified - prints instructions)
# In real implementation, would use socket module
func run(app, port) {
    print format("🌐 Starting Chara Web Server on port {}", port)
    print format("📍 Routes: {} registered", len(app["routes"]))
    print ""
    print "Routes:"
    for path in app["routes"] {
        print format("  {} -> {}", path, app["routes"][path])
    }
    print ""
    print format("Visit: http://localhost:{}", port)
    print "Press Ctrl+C to stop"
}

# Example app
func example() {
    set app = call create()
    
    call route(app, "/", "Welcome to Chara Web!")
    call route(app, "/api/hello", "json_handler")
    call route(app, "/about", "about_page")
    
    call run(app, 8080)
}
