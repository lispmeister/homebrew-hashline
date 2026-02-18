class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "1c2e965599f394184466d2e8df19525bc4dee3d5614f3d9eb7f7036fec183825"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "4a60011e15daf6783905d4278bce9f41a9bcfb2d46b69cbf907feceb9b8a446b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e647adc48446450b2529c045ed0b0bc8188c354b8538fc3ef62617f75b53ecbf"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "105a9ad743f15212133fde4c810729f60533a98b701b3766aef50f639a1ad2c7"
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
