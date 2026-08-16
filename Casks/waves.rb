# Homebrew cask template for Waves.
#
# The release workflow validates `version`, replaces the intentionally invalid
# checksum placeholder in a generated dist/waves.rb, and publishes that generated
# file as a release artifact. It does not mutate this repository template.
cask "waves" do
  version "1.6.0"
  sha256 "c12609080a69ca72abd57aeb3a4531488c29a3be7e1635dcffa12ddede79cf12"

  url "https://github.com/JonathanRReed/Waves/releases/download/v#{version}/Waves.dmg",
      verified: "github.com/JonathanRReed/Waves/"
  name "Waves"
  desc "Native per-app audio mixer"
  homepage "https://github.com/JonathanRReed/Waves"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Per-app routing requires Core Audio process taps — macOS 14.2 is the floor
  # (matches LSMinimumSystemVersion). Homebrew's depends_on only understands
  # major versions, so gate on Sonoma here; the app itself refuses 14.0/14.1
  # with its unsupported-OS path.
  depends_on macos: :sonoma

  app "Waves.app"

  zap trash: [
    "~/.Waves",
    "~/Library/Application Support/Waves",
    "~/Library/Preferences/com.jonathanreed.Waves.plist",
  ]
end
