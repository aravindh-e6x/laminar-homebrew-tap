class LaminarDemo < Formula
  desc "Self-contained local demo of the Laminar data engine"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.22/laminar-demo-v0.1.22-aarch64-apple-darwin.tar.gz"
  version "0.1.22"
  sha256 "ec98634d17cc1e77d37bba0c5ae416ab90f557102eb25723a07002d58a68d828"
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
