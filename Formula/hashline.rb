class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.15"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "a60d765cd78a931a9bcf25fa02a40f760824c075e9bbab3cdcce02f5410cb61a"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "ccf7fe969095a73d4b26a493a527edef26b5ed85f761309e9a489d47809e7b49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "61de459ba8a63c5e142f9526184a9f0f8de80290b9274939f0babbda96d6b10d"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "56446c652a66e632d36161ab00260a104650ce29b6db64c7cc1f86ef1d2a29eb"
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
