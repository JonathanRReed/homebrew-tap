# Homebrew cask template for Waves.
#
# The release workflow validates `version`, replaces the intentionally invalid
# checksum placeholder in a generated dist/waves.rb, and publishes that generated
# file as a release artifact. It does not mutate this repository template.
cask "waves" do
  version "1.6.0"
  sha256 "a0fb52f5c9783bed938a6bc0683f6bdf69a5f527dcd20da5dd35958362a93b4b"

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
