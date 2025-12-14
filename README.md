# Chara Packages 📦

Official package registry for the [Chara Programming Language](https://github.com/Clypus/Chara).

## Installation

Use the Chara Package Manager (cpm):

```bash
# Install a package
python3 tools/cpm.py install chara-web

# Or using the shorthand
cpm install chara-ai
```

## Available Packages

| Package | Description | Use As |
|---------|-------------|--------|
| **chara-web** | Web framework with routing & templates | `import web` |
| **chara-ui** | Terminal UI with colors & menus | `import tui` |
| **chara-game** | 2D game development framework | `import game` |
| **chara-data** | Data science & visualization | `import data` |
| **chara-ai** | Machine learning utilities | `import ai` |
| **chara-utils** | Common utility functions | `import utils` |

## Quick Examples

### Web Framework
```chara
import web

set app = call web.create()
call web.route(app, "/", "Hello World!")
call web.run(app, 8080)
```

### Terminal UI
```chara
import tui

call tui.clear()
call tui.title("My App")
call tui.success("It works!")
call tui.progress(75, 100)
```

### Data Science
```chara
import data

set values = [10, 25, 15, 30, 20]
print call data.mean(values)   # 20
print call data.max(values)    # 30
call data.plot(values, "bar")
```

### Machine Learning
```chara
import ai

set model = call ai.linear_regression()
call ai.fit(model, [1,2,3,4,5], [2,4,6,8,10])
set pred = call ai.predict(model, [6])
print pred  # [12]
```

## Creating Packages

To create a new package:

1. Create a directory in this repo: `chara-mypackage/`
2. Add your main module: `chara-mypackage/mypackage.ch`
3. Add a README.md with documentation
4. Submit a pull request

### Package Structure

```
chara-mypackage/
├── mypackage.ch      # Main module
├── README.md         # Documentation
└── examples/         # Usage examples (optional)
    └── demo.ch
```

## License

MIT License

---

🦎 Made for Chara Lang by the community
