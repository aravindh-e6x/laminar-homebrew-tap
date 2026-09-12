class LaminarDemo < Formula
  desc "Self-contained local demo of the Laminar data engine"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.21/laminar-demo-v0.1.21-aarch64-apple-darwin.tar.gz"
  version "0.1.21"
  sha256 "78cd92f99d6d004de365e5c0e8c094d87526a85ff510a210311f73a501cdd8cf"
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
