cask "throne" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.2"
  sha256 arm:   "c56b99af9153e09ad152b42cfd2975027a097a364ddc65f66f8ea6c4476f4c0d",
         intel: "b7ef9f8a2a0c8b8f798ae03bb76479ce2f24f835e0ee440a6beaa3e9ed2df938"

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
