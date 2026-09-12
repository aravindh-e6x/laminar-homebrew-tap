class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.23/laminar-v0.1.23-aarch64-apple-darwin.tar.gz"
  version "0.1.23"
  sha256 "1e0b11b103917a587d9304ecc7941da15f2c44aa5382b1a6de904095bb1472c8"
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
