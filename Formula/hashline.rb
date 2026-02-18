class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "e7b08db51f1d6c53de8c6d27559a783a309399664a115258c40a43912cac970e"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "ab9af48533b28da1131a1393a11fe525a079e2a11058be7a4a81f5389c51bc73"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9b98d6728fbc796f839be3af2a4c2a6d7a5d717761a368ecfd84d2b8931b02bb"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2cc229b443af853a315931a988db5510c2a0c8dd4a6a005152d5d96b8787ee5e"
    end
  end

  def install
    bin.install "hashline"
    man1.install Dir["man/*.1"]
  end

  test do
    (testpath/"test.txt").write("hello world
")
    output = shell_output("#{bin}/hashline read #{testpath}/test.txt")
    assert_match "1:", output
    assert_match "hello world", output
  end
end
