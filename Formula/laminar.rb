class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.24/laminar-v0.1.24-aarch64-apple-darwin.tar.gz"
  version "0.1.24"
  sha256 "96f7dc2b7baeef4b3184d2dbfcabe8d4a4968964d62e1cffffb3672dc2bdd53b"
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
