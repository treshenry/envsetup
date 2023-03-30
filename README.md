# WARNING

This is my own crap for my own twisted uses. It's not for you!

## Structure

Old vim stuff has been moved to /vim

/vscode has keybindings.json and settings.json which need to find their way to:

- Mac: ```/Users/tres/Library/Application Support/Code/User```
- Linux: ```/home/tres/.config/Code/User```

For example:

### Mac

```
ln -s /Users/tres/Documents/src/envsetup/vscode/settings.json /Users/tres/Library/Application\ Support/Code/User/settings.json
ln -s /Users/tres/Documents/src/envsetup/vscode/keybindings.json /Users/tres/Library/Application\ Support/Code/User/settings.json
```

### Linux

```
ln -s /home/tres/Documents/src/envsetup/vscode/settings.json /home/tres/.config/Code/User/settings.json
ln -s /home/tres/Documents/src/envsetup/vscode/keybindings.json /home/tres/.config/Code/User/keybindings.json
```

