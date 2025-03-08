class FabricCli < Formula
  desc "Open-source framework for augmenting humans using AI."
  homepage "https://github.com/danielmiessler/fabric"
  version "1.4.152"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-arm64"
      sha256 "3ee236ff8c41a76f7d3e4af43707015aca3838803fa13c506b45d428dc7f61ca"
    else
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-amd64"
      sha256 "fc5110777e33be44cf78ee7e021423f4cdc9443d881420ae66b32da5264bf030"
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
