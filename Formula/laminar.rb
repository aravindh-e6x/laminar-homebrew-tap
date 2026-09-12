class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.22/laminar-v0.1.22-aarch64-apple-darwin.tar.gz"
  version "0.1.22"
  sha256 "96bb819f6909dbfcb84fd91b9db9f5c2a8c48cf3ad6e10c05dc0c2019331cfd4"
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
