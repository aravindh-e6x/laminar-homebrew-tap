class LaminarDemo < Formula
  desc "Self-contained local demo of the Laminar data engine"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.20/laminar-demo-v0.1.20-aarch64-apple-darwin.tar.gz"
  version "0.1.20"
  sha256 "98b81a31fe6d2e51eaabc1bd6f70ffd40610a179eb530eab87377d7dd2f64c8f"
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
