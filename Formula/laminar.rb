class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.15/laminar-v0.1.15-aarch64-apple-darwin.tar.gz"
  version "0.1.15"
  sha256 "6ca1d93a7f7f47ca53e7e2ef7f436d060d5ba1fe979e2d777edf2a4cea3cfd52"
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
