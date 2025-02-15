cask "apiparrot" do
    version "0.3.1"
    sha256 "9546ad72e4b06e2bb6a917474b9708b73b8bbbba95508c69d40a195e769bedb4"
  
    url "https://github.com/apiparrot/apiparrot-desktop-releases/releases/download/v#{version}/API-Parrot-#{version}-universal.dmg"
    name "API Parrot"
    desc "Tool for reverse engineering HTTP APIs"
    homepage "https://apiparrot.com/"
  
    app "API Parrot.app"
  
    zap trash: [
      "~/Library/Application Support/API Parrot",
      "~/Library/Preferences/com.apiparrot.app.plist",
      "~/Library/Saved Application State/com.apiparrot.app.savedState",
    ]
  end