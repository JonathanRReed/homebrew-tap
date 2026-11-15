# Homebrew cask template for Waves.
#
# The release workflow validates `version`, replaces the intentionally invalid
# checksum placeholder in a generated dist/waves.rb, and publishes that generated
# file as a release artifact. It does not mutate this repository template.
cask "waves" do
  version "1.7.4"
  sha256 "ef4ef404b16a94b0d20a57bf32217dd3915913981c355263cbf7b4b149baa9ce"

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
