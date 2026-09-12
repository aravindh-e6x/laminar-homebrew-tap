class LaminarDemo < Formula
  desc "Self-contained local demo of the Laminar data engine"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.19/laminar-demo-v0.1.19-aarch64-apple-darwin.tar.gz"
  version "0.1.19"
  sha256 "36af97e39e90042f23db7c606ddfbd68ae80bf3a61a0d402f420311b0bb41ad1"
  license any_of: ["Apache-2.0", "MIT"]

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "laminar-demo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/laminar-demo --version")
  end
end
