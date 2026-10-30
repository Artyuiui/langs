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
- Detects the language from the file extension or filename (e.g. `Makefile`, `Dockerfile`), using GitHub
  linguist's list: 530+ languages with GitHub's names and colors. Related languages are grouped as on GitHub
  (e.g. `.tsx` counts as TypeScript).
- Where an extension is shared (`.h` = C/C++/Objective-C), GitHub reads the file contents; `langs` picks the
  most common language, so those files may be labelled differently.

## Updating the language list

```bash
curl -fsSL https://raw.githubusercontent.com/github-linguist/linguist/main/lib/linguist/languages.yml | ruby gen-languages.rb
```

## Uninstall

```bash
sudo rm /usr/local/bin/langs
```
