class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "c1a0bb7222fb65ddd7e4d346c903a317092ad2e01702284e74536573a26dd4bc"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "cc745b1d740f6a70d3db5fe3f086005a17bbe7b81fca72d15c9215f839431ffb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "13c703d9bd6d4d6dc6686e96915525a9328ed581c4503bf06e7a7bb9e5ed9247"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b70211fccde322c9a251bbae9cab020a80374617ab3f88b6819e1801c1feb980"
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
