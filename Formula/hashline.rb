class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "b5afdf53d425d684f0bf6788664328cebee5eb2d334bc55bfe3f5ba2ea01f745"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "cec16dde4248bdf8463822015348eb673ad65886743b05ad37923098a26f8939"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb08830965484628a5b86e5ff228768f1717cc81fcc47eb58bdfbc62d83255ed"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3b8a1960635fc4b68918361249481341f736d85cec95fa7c0ec40a5a3150f8c2"
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