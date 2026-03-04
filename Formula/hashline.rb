class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "c481e999ba7ce01ef2c3a89bd511d35a9092da2d31fb7790adcc91c4a0b71992"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "6e0e886be91a700d0e03a501e05f66d204a6abc3cd163bbdfbfb57799232deca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1b326523e1d322f350275ba7115701fa84ab996417e270273843d4cdb5cf7615"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ce3fea4d210a16c04ba07ac6d3c15f2e71fed71229e26731ab045d275936c02"
    end
  end

  def install
    bin.install "hashline"
    man1.install Dir["man/*.1"]
  end

  def caveats
    <<~EOS
      To use hashline with Claude Code, install the skill (one-time):

        mkdir -p ~/.claude/skills/hashline-setup
        curl -fsSL https://raw.githubusercontent.com/lispmeister/hashline/main/contrib/skills/hashline-setup/SKILL.md \\
            -o ~/.claude/skills/hashline-setup/SKILL.md

      Then run /hashline-setup in any project to activate the hooks.

      For other agents (Cursor, Windsurf, etc.), see:
        https://github.com/lispmeister/hashline#agent-integration
    EOS
  end

  test do
    (testpath/"test.txt").write("hello world\n")
    output = shell_output("#{bin}/hashline read #{testpath}/test.txt")
    assert_match "1:", output
    assert_match "hello world", output
  end
end
