cask "apiparrot" do
    version "0.3.0"
    sha256 "e2b8e5c238e1931325dc301671e2b168fcf3cab9345160e424bc593863df7c14"
  
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