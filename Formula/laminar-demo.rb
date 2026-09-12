class LaminarDemo < Formula
  desc "Self-contained local demo of the Laminar data engine"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.26/laminar-demo-v0.1.26-aarch64-apple-darwin.tar.gz"
  version "0.1.26"
  sha256 "e9d750404bdbf6d115825ecd63b72a039152a2cf70b96e14337f735abfb81d9a"
  license any_of: ["Apache-2.0", "MIT"]

  depends_on :macos
  depends_on arch: :arm64

  def install
    libexec.install "laminar-demo"
    libexec.install "python"

    (bin/"laminar-demo").write_env_script(
      libexec/"laminar-demo",
      LAMINAR_NOTEBOOK_PYTHON: libexec/"python/bin/python3",
    )
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/laminar-demo --version")
    system bin/"laminar-demo", "--help"
    system libexec/"python/bin/python3", "-c",
           "import ipykernel, jupyter_client, pyspark"
  end
end
