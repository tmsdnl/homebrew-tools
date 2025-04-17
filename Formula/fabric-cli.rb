class FabricCli < Formula
  desc "Open-source framework for augmenting humans using AI."
  homepage "https://github.com/danielmiessler/fabric"
  version "v1.4.172"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-arm64"
      sha256 "b75184ea7857ce5028d6b163a9e34f9bf26cb80b981ff3edb81034c4de01d719"
    else
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-amd64"
      sha256 "3d6038f480bf7479e2975ee8e97234ecd0b568dd82d35e40472675ee99a0bcee"
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
