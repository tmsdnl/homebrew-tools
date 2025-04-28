class FabricCli < Formula
  desc "Open-source framework for augmenting humans using AI."
  homepage "https://github.com/danielmiessler/fabric"
  version "v1.4.185"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-arm64"
      sha256 "ccb4e0851dfc79372f68a8bd941567342b965aeb9d69137fad7b318b3f75853a"
    else
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-amd64"
      sha256 "edddd3708632e9d3d65ab49f5713b5b6fa7e5d740deec17fb20e7c8af4bc18af"
    end
  else
    odie "Fabric is currently only supported on macOS."
  end

  def install
    mv cached_download, "fabric"
    bin.install "fabric"
    chmod "+x", bin/"fabric"
  end

  test do
    assert_match "Fabric", shell_output("#{bin}/fabric --version")
  end
end
