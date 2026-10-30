# langs

Shows a GitHub-style language breakdown of any project in your terminal.

```
  Languages

  ████████████████████████████████████████████████████

  ● JavaScript    76.2%
  ● HTML          19.0%
  ● Swift          2.4%
  ● CSS            2.4%
```

## Install (macOS)

```bash
curl -fsSL https://raw.githubusercontent.com/Artyuiui/langs/main/install.sh | bash
```

This installs the command to `/usr/local/bin/langs` and asks for your password once.

## Usage

```bash
langs            # current folder
langs ~/my-app   # another folder
```

## How it counts

- Counts by file size (bytes), the same way GitHub does.
- In a git repo it respects `.gitignore`. Outside one it skips `node_modules`, `dist`, `build`, `Pods` and similar folders.
- Skips `.min.js`/`.min.css` and data or prose files such as JSON and Markdown.
- Detects the language from the file extension (26 languages). To add one, add a line to the `BEGIN` block in `langs`:
  `L["scala"] = "Scala|194;45;64"`

## Uninstall

```bash
sudo rm /usr/local/bin/langs
```
