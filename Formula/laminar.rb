class Laminar < Formula
  desc "Unified engine for queries, streaming, and data workloads"
  homepage "https://github.com/e6data/laminar-releases"
  url "https://github.com/e6data/laminar-releases/releases/download/v0.1.1/laminar-0.1.1-darwin-arm64.zip"
  version "0.1.1"
  # The old personal tap used a different version sequence.
  version_scheme 1
  sha256 "19ecfd0d38c659e3068ff944a7f072c973b8467d60bf5c503bfc643fb47d81d6"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on arch: :arm64
  depends_on macos: :sonoma

  # ICU has its own extension signature. Keep bundled library IDs unchanged.
  preserve_rpath

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/laminar"
  end

  def caveats
    <<~EOS
      Run laminar, then open http://127.0.0.1:15003/.
      Config and data are kept in ~/Library/Application Support/Laminar.
      Set LAMINAR_HOME to use another directory.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/laminar --version")
    system libexec/"runtime/python/bin/python3", "-I", "-c",
           "import laminar, pyarrow, ipykernel, pandas; from pyspark.sql import SparkSession"
  end
end
