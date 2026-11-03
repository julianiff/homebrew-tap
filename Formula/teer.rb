class Teer < Formula
  desc "teer: the essence of every revision. Semantic code review in the terminal."
  homepage "https://github.com/julianiff/teer"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.2.0/teer-aarch64-apple-darwin.tar.xz"
      sha256 "bddffe7b701490f7d27200450abad73a5a53449d27d789c66b976f517fa78d66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.2.0/teer-x86_64-apple-darwin.tar.xz"
      sha256 "eb170401219b2acc93b63f82e7630f38503e845545ef30635a3b5b89cb8eb779"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.2.0/teer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dbbdfd7390693c0b6370ac656d612b09c2d5e032bfb100d2b0418f5f14927c39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.2.0/teer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6b5dec7595de30ce74e62b22132031b1bcae1a6af6ca9d71eec626bb126e8980"
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
