class Laminar < Formula
  desc "Unified engine for queries, streaming, and data workloads"
  homepage "https://github.com/e6data/laminar-releases"
  url "https://github.com/e6data/laminar-releases/releases/download/v0.1.2/laminar-0.1.2-darwin-arm64.zip"
  version "0.1.2"
  # The old personal tap used a different version sequence.
  version_scheme 1
  sha256 "69a317eb62921a87fad6d3cea1a9a2fa6234b6be010287f068274cf90dd046a1"
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
