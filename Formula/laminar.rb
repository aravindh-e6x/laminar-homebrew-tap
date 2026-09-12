class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.19/laminar-v0.1.19-aarch64-apple-darwin.tar.gz"
  version "0.1.19"
  sha256 "a6bdb34150ddd0b1eeaedc7d0e9075e446b89f70c7505bde9b10e2bbddaa1b09"
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
