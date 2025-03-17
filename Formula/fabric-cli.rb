class FabricCli < Formula
  desc "Open-source framework for augmenting humans using AI."
  homepage "https://github.com/danielmiessler/fabric"
  version "1.4.159"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-arm64"
      sha256 "e6274e4879de61fadac65f1876da87f834d71ecfb94c27e32a5067ec34afc894"
    else
      url "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-amd64"
      sha256 "3ad6cf0a333b8999903fc023dccf697930851f1adf0c4c76d1103faa5e63e67c"
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
