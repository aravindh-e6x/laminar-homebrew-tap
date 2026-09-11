class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.1/laminar-v0.1.1-aarch64-apple-darwin.tar.gz"
  version "0.1.1"
  sha256 "b7d7d8643b3c5720dec0c3ed28272ce75f198e349097cee9e1999d2da92f0c0c"
  license any_of: ["Apache-2.0", "MIT"]

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "laminar"
    pkgshare.install "console"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/laminar --version")
  end
end
