class Teer < Formula
  desc "teer: the essence of every revision. Semantic code review in the terminal."
  homepage "https://github.com/julianiff/teer"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.1.1/teer-aarch64-apple-darwin.tar.xz"
      sha256 "a73d0161d1ba7742596cb1cdd242bb7e379267ce5a737e46e62a66fcd4404437"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.1.1/teer-x86_64-apple-darwin.tar.xz"
      sha256 "29133d2d8aa269e1129a34b2c178b568d40278b005c5962cbb2b0fdd9bd07e1e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/julianiff/teer/releases/download/v0.1.1/teer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6d701126b91ea7aab0de9ccceb1886fe5623ccc53ea82b8ff9e39aa4530f1e40"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julianiff/teer/releases/download/v0.1.1/teer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "492e50df3dbb7e957cc688ac15277aa898216d79a994b7595c0ba1d4ace6dafb"
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
