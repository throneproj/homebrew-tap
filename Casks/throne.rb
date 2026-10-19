cask "throne" do
  arch arm: "arm64", intel: "amd64"

  version "1.3.2"
  sha256 arm:   "c5371633f17e46d18d999206a79bafe4ec1b20e03acf51171261f3084b702b16",
         intel: "b5312bd4b6aceb5d2107be06fb6a407ec4da5159c5da0b428ac26c784bf404a9"

  url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-#{arch}.zip"
  name "Throne"
  desc "Cross-platform GUI proxy utility powered by sing-box"
  homepage "https://github.com/throneproj/Throne"

  depends_on macos: :ventura

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
