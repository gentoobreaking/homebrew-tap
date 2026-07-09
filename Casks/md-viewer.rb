cask "md-viewer" do
  version "0.2.3"
  sha256 :no_check

  url "https://github.com/gentoobreaking/md-viewer/releases/download/v#{version}/md-viewer-#{version}.dmg"

  name "md-viewer"
  desc "Markdown 文件檢視器"
  homepage "https://github.com/gentoobreaking/md-viewer"

  app "md-viewer.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/md-viewer.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/md-viewer",
    "~/Library/Preferences/md-viewer.plist",
  ]
end
