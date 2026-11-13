class Teer < Formula
  desc "teer: the essence of every revision. Semantic code review in the terminal."
  homepage "https://github.com/julianiff/teer"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.4.0/teer-aarch64-apple-darwin.tar.xz"
      sha256 "d04544693685ce34e8095eb586423eb259212975763c7616ee4c6a6052cd8d17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.4.0/teer-x86_64-apple-darwin.tar.xz"
      sha256 "11b3e8a0d9c9307c2d134bdbc67e34d425975ffbd303b8d13fa4eec2c823041f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.4.0/teer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4d194a1fe5043230a57ae5bb4180af5d117763173e4a81c1300b03294da1ec49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.4.0/teer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "83d61f5c2919b38364ef142ab70655fdae5f8b1d61d60f186791c95ca2fb2ee5"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "teer"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "teer"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "teer"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "teer"
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
