class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.4/laminar-v0.1.4-aarch64-apple-darwin.tar.gz"
  version "0.1.4"
  sha256 "a1cc852d4d4aadf6313a7b550b4864cf19abecc5f4d38e84bbc21311d09016a3"
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
