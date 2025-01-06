cask "apiparrot" do
    version "0.2.3"
    sha256 "9a92174b1533dab4150b355bf740b06aa5329076f8a1b566dfbc3d5ac7bcef1f"
  
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