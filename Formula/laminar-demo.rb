class LaminarDemo < Formula
  desc "Self-contained local demo of the Laminar data engine"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.25/laminar-demo-v0.1.25-aarch64-apple-darwin.tar.gz"
  version "0.1.25"
  sha256 "26af7e620332d07e906559b2c334c0ccabf14e26e5567298aa650432e5f86b3a"
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
