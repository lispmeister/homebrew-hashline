class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "dca2b494e635addd763c383903f7910fb68f24407abb979d09497d7715fc6977"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "d94b7425a1b0b710f822199559b405004ad232d73541bea5d62cb7d3ed8b2f5a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "14d223311dc55b68b50057da58e674dd063e10608e3f5aceecf47622a6998d82"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "620b4a66af4512914f9d3dff5f64431685f02738e14f87f5024d08882c1d373e"
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
