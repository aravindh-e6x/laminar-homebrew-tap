class LaminarDemo < Formula
  desc "Self-contained local demo of the Laminar data engine"
  homepage "https://github.com/aravindh-e6x/laminar-homebrew-tap"
  url "https://github.com/aravindh-e6x/laminar-homebrew-tap/releases/download/v0.1.23/laminar-demo-v0.1.23-aarch64-apple-darwin.tar.gz"
  version "0.1.23"
  sha256 "b998178a63c3d1012da33bc5515be08d337add2f16863297c66ef6161689383f"
  license any_of: ["Apache-2.0", "MIT"]

  depends_on :macos
  depends_on arch: :arm64
  depends_on "python@3.11"

  def install
    libexec.install "laminar-demo"
    libexec.install "wheels"

    python = Formula["python@3.11"].opt_bin/"python3.11"
    system python, "-m", "venv", libexec/"python"
    system libexec/"python/bin/python", "-m", "pip", "install",
           "--disable-pip-version-check", "--no-index",
           "--find-links", libexec/"wheels",
           "-r", libexec/"wheels/requirements.txt"

    (bin/"laminar-demo").write_env_script(
      libexec/"laminar-demo",
      LAMINAR_NOTEBOOK_PYTHON: libexec/"python/bin/python",
    )
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/laminar-demo --version")
    system bin/"laminar-demo", "--help"
    system libexec/"python/bin/python", "-c", "import ipykernel, jupyter_client, pyspark"
  end
end
