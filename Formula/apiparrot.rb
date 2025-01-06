cask "apiparrot" do
    version "0.2.3"
    sha256 "65a7e39a52c9e9a2bb5265ba340e1e5655b7ad02" # Replace with the actual SHA256 hash
  
    url "https://github.com/apiparrot/apiparrot-desktop-releases/releases/download/v#{version}/API_Parrot-#{version}.dmg"
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