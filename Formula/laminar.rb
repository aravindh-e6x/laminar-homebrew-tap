class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.18/laminar-v0.1.18-aarch64-apple-darwin.tar.gz"
  version "0.1.18"
  sha256 "353ef01c9d9ae354bebad184f944b6f24ed1e72542477a8fd7bb386bf1e0eb52"
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
