# Chara Web Framework

A simple, elegant web framework for the Chara programming language.

## Installation

```bash
chara install chara-web
```

## Quick Start

```chara
import web

# Create app
set app = call web.create()

# Add routes
call web.route(app, "/", "Hello World!")
call web.route(app, "/api/users", "get_users")

# Run server
call web.run(app, 8080)
```

## Features

- 🛣️ **Routing** - Simple path-based routing
- 📝 **Templates** - Built-in template rendering
- 🔧 **Middleware** - Request/response processing
- 📁 **Static Files** - Serve static assets
- 🍪 **Cookies** - Cookie handling helpers
- 📦 **JSON** - JSON response helpers

## API Reference

### `web.create()`
Create a new web application.

### `web.route(app, path, handler)`
Add a route. Handler can be a string response or function name.

### `web.html(content)`
Wrap content in HTML boilerplate.

### `web.json_response(data)`
Convert data to JSON response.

### `web.render(template, vars)`
Simple template rendering with `{variable}` placeholders.

### `web.redirect(location)`
Create redirect response.

### `web.parse_query(query_string)`
Parse query string into map.

### `web.run(app, port)`
Start the web server.

## Examples

### REST API

```chara
import web
import json

set app = call web.create()

func get_users() {
    set users = [
        {"id": 1, "name": "Alice"},
        {"id": 2, "name": "Bob"}
    ]
    return call web.json_response(users)
}

call web.route(app, "/api/users", "get_users")
call web.run(app, 3000)
```

### Template Rendering

```chara
import web

set template = "<h1>Hello, {name}!</h1><p>Welcome to {site}</p>"
set vars = {"name": "User", "site": "Chara Web"}
set result = call web.render(template, vars)

print result
# Output: <h1>Hello, User!</h1><p>Welcome to Chara Web</p>
```

## License

MIT License - Created for Chara Lang
