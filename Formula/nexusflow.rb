class Nexusflow < Formula
  desc "Universal Rust data & vector framework — ETL/ELT/streaming + AI Lakehouse Builder"
  homepage "https://github.com/ailake-io/nexusflow"
  url "https://github.com/ailake-io/nexusflow/releases/download/v0.1.7/nexusflow-macos-arm64.tar.gz"
  sha256 "acbc28dfcd240012bec46317d40e21f13f7a19d0a0c9b4152be9af43ea3352c7"
  license "Apache-2.0"

  depends_on macos: :ventura

  def install
    bin.install "nexusflow-bin" => "nexusflow"
    # Real bug caught filling in this formula the first time (2026-09-06):
    # the tarball's ClickHouse driver is named `libadbc_clickhouse.dylib`
    # (no "driver_" — matches build-adbc-clickhouse-driver.sh's own output
    # name), so a `Dir["libadbc_driver_*"]` glob silently skips it.
    lib.install Dir["libadbc_*"]
  end

  def caveats
    <<~EOS
      NexusFlow needs two required environment variables to start:
        export NEXUS_JWT_SECRET="$(openssl rand -hex 32)"
        export NEXUS_ENCRYPTION_KEY="$(openssl rand -hex 32)"

      And the four ADBC driver paths, installed alongside this formula's lib/:
        export ADBC_DRIVER_POSTGRESQL_PATH="#{lib}/libadbc_driver_postgresql.dylib"
        export ADBC_DRIVER_SQLITE_PATH="#{lib}/libadbc_driver_sqlite.dylib"
        export ADBC_DRIVER_DUCKDB_PATH="#{lib}/libadbc_driver_duckdb.dylib"
        export ADBC_DRIVER_CLICKHOUSE_PATH="#{lib}/libadbc_clickhouse.dylib"

      See https://github.com/ailake-io/nexusflow/blob/main/docs/GETTING_STARTED.md
      for the full list of environment variables and how to run your first
      pipeline.
    EOS
  end

  test do
    system "#{bin}/nexusflow", "--version"
  end
end
