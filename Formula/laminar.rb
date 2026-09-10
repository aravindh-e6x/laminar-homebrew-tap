class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.0/laminar-v0.1.0-aarch64-apple-darwin.tar.gz"
  version "0.1.0"
  sha256 "89018e47c068aeef4509d26252db83b2837aeecda72c18326ed5087f2e8c38e8"
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
