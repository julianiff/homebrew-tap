class Teer < Formula
  desc "teer: the essence of every revision. Semantic code review in the terminal."
  homepage "https://github.com/julianiff/teer"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.1.0/teer-aarch64-apple-darwin.tar.xz"
      sha256 "8a9e05d88e1b1a5bae797331d9061375b832017bece7a743c8b1e6b6eb9b7af8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.1.0/teer-x86_64-apple-darwin.tar.xz"
      sha256 "7126be23edd6b4030c0ca881a4015188882ad9d0f6f1c9536b64df91ad2fac57"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.1.0/teer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eead09575181889c9543333e928f416e35ebaf3e179ed76416fcebafd88a68b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.1.0/teer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8163e402501ceeabf10760d657373e111095baf9416a58efdda44eb022a8fbe9"
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
