class BunnycdnMcp < Formula
  desc "Lightweight MCP server for operating the bunny.net CDN"
  homepage "https://github.com/JeffersonCN/bunnycdn-mcp"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/JeffersonCN/bunnycdn-mcp-server/releases/download/v0.1.0/bunnycdn-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "6eababa144046ccdad6a6939e9073c038325e6297316c1f9e1d8559b654d600e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/JeffersonCN/bunnycdn-mcp-server/releases/download/v0.1.0/bunnycdn-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "106603b83a5b4673c99e78da64a1b52b4819c29484fcf4757763a3433930e1b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/JeffersonCN/bunnycdn-mcp-server/releases/download/v0.1.0/bunnycdn-mcp-aarch64-unknown-linux-musl.tar.xz"
      sha256 "24b575b86315a36c1754393858fbd6beae31505c09c746c9bde6958663127f49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/JeffersonCN/bunnycdn-mcp-server/releases/download/v0.1.0/bunnycdn-mcp-x86_64-unknown-linux-musl.tar.xz"
      sha256 "daede25691d74ea260a31c4d2bedc3b24033a7ae9f4c43831769059e1939b20e"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "bunnycdn-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bunnycdn-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bunnycdn-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bunnycdn-mcp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
