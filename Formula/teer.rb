class Teer < Formula
  desc "teer: the essence of every revision. Semantic code review in the terminal."
  homepage "https://github.com/julianiff/teer"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.3.0/teer-aarch64-apple-darwin.tar.xz"
      sha256 "eec85e8230bdf15f75a700542d6934ebb91a9a070499b07ec9142f8ef5312091"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.3.0/teer-x86_64-apple-darwin.tar.xz"
      sha256 "544976ca024d8955676d63e019b71bd606f4e1299df50b52e06cdd5da5b926a3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.3.0/teer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f0e85bf8cb3a6570f1062e489b86673339acbb08b9a69182965307316009e165"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.3.0/teer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "688994b4e57e3bbf5d287398ab870dfdae96c9fddcd051ce31daa64fe502d440"
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
