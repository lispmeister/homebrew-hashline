class Hashline < Formula
  desc "Content-addressable line editing tool for AI coding assistants"
  homepage "https://github.com/lispmeister/hashline"
  version "0.1.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-apple-darwin.tar.gz"
      sha256 "0572119a9e319b0de30394f7fee8d8987836db5473c69663422fdfe11af918bf"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-apple-darwin.tar.gz"
      sha256 "c30ffeb803bfc67fb469f67068f469ec850754849981a966a682361e48b98a74"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "030cef55472416431e8410d6712ccd4ad8e3ec306f6497015440e0de5c9e617c"
    end
    on_intel do
      url "https://github.com/lispmeister/hashline/releases/download/v#{version}/hashline-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f9de428bb957d5d33f0c42dbe0bdbbab56540ad283ab199616712b5cd0e1eee8"
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
