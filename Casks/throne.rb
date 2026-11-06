cask "throne" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.1"
  sha256 arm:   "50766e6563878810c8a43f1e42ae9a79c94c9e2e57122e48a57427d745bcc755",
         intel: "9980a1b8b27e39c184f0e49ca3e51392f39fc1f90a1c93411c90c673748366ac"

  url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-#{arch}.zip"
  name "Throne"
  desc "Cross-platform GUI proxy utility powered by sing-box"
  homepage "https://github.com/throneproj/Throne"

  # The app needs macOS 14.4 (Qt 6.12); Homebrew has no minor-version floor, and LSMinimumSystemVersion refuses 14.0-14.3.
  depends_on macos: :sonoma

  app "Throne/Throne.app"

  # Releases are ad-hoc signed, not notarized, so Gatekeeper refuses a quarantined first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Throne.app"],
        print_stderr: false
  end

  zap trash: "~/Library/Preferences/Throne"

  caveats <<~EOS
    Throne is not notarized by Apple. This cask removes the quarantine attribute
    from #{appdir}/Throne.app so that it opens without a Gatekeeper prompt.

    Tun mode asks for your password to make ThroneCore setuid root. Each upgrade
    replaces the app, so Throne asks again after it.
  EOS
end
