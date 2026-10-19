# Throne Homebrew tap

```bash
brew install --cask throneproj/tap/throne
```

Upgrade with `brew upgrade --cask throne`. `brew uninstall --zap --cask throne` also removes `~/Library/Preferences/Throne`.

Throne's macOS builds are not notarized by Apple. The cask removes the quarantine attribute from `Throne.app` after installing it, so the first launch is not blocked by Gatekeeper.
