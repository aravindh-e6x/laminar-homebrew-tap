class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.11/laminar-v0.1.11-aarch64-apple-darwin.tar.gz"
  version "0.1.11"
  sha256 "c95b0cef7d8917987b23e6673cb6dd5ee0a9684d17be7aec8d609661ea7d0b7f"
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
