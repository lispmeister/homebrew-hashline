class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "aff66846ee1695275f4a870c892017f9c4b49396ab9aa1ef99e25b1df6c526d1"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "1e33809bc131f670dc7a63dad2eb48cb6ab3c937479560b1b842dc7befb08871"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "28e9e8a656fdd9d4aa0e448837d0688e327182c7a755fbb26107c5475d2aa80b"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32e667843407ac9fb60ce27c192d4022cdbb5c2515d2e8a681517e017c60d0ec"
    end
  end

  def install
    bin.install "hashline"
    man1.install Dir["man/*.1"]
  end

  test do
    (testpath/"test.txt").write("hello world\n")
    output = shell_output("#{bin}/hashline read #{testpath}/test.txt")
    assert_match "1:", output
    assert_match "hello world", output
  end
end
