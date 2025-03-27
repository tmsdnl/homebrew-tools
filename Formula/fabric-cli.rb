class FabricCli < Formula
  desc "Open-source framework for augmenting humans using AI."
  homepage "https://github.com/danielmiessler/fabric"
  version "v1.4.165"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-arm64"
      sha256 "105f0d588c200b65c4f4d671715fa4e50e60655167739359b9380bf09ebc31bf"
    else
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-amd64"
      sha256 "058eac7f0fe99ffd9e50e51b714453a8bf4750fcbbbb051ab5560d4a26abdeb8"
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
