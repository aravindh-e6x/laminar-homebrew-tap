class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.20/laminar-v0.1.20-aarch64-apple-darwin.tar.gz"
  version "0.1.20"
  sha256 "8061b542fd33906a7d134d87cd74f5792fbd56caef95bec30afc95bd19b885fe"
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
