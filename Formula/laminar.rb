class Laminar < Formula
  desc "Distributed data engine for query, ETL, and streaming workloads"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.5/laminar-v0.1.5-aarch64-apple-darwin.tar.gz"
  version "0.1.5"
  sha256 "2784ec63d6d37fd5a24af6ef7aaf887fc3ab0353e5ad64fc54469834db97c6a6"
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
