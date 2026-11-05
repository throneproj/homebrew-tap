cask "throne" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.0"
  sha256 arm:   "2b1b00af31ad4399f8bf5e1116011d566167ad33d54dc542fa2eafe23ff240c6",
         intel: "b2eb70db2de2f57f800a836d4cfd6fc31eeb3224e1a1c267be2381672cef30bd"

  url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-#{arch}.zip"
  name "Throne"
  desc "Cross-platform GUI proxy utility powered by sing-box"
  homepage "https://github.com/throneproj/Throne"

  # The app needs macOS 14.4 (Qt 6.12); Homebrew has no minor-version floor, and LSMinimumSystemVersion refuses 14.0-14.3.
  depends_on macos: :sonoma

  app "Throne/Throne.app"

  # Releases are ad-hoc signed, not notarized, so Gatekeeper refuses a quarantined first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Throne.app"],
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
