class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.26/laminar-v0.1.26-aarch64-apple-darwin.tar.gz"
  version "0.1.26"
  sha256 "692c05a60d2d3900545a968d4f3bbf5d6e4d8be9f6b5b9919f7f03bef19cd3bf"
  license any_of: ["Apache-2.0", "MIT"]

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "laminar"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/laminar --version")
  end
end
