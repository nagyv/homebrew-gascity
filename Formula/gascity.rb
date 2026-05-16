# typed: false
# frozen_string_literal: true

class Gascity < Formula
  desc "Orchestration-builder SDK for multi-agent coding workflows"
  homepage "https://github.com/nagyv/gascity"
  head "https://github.com/nagyv/gascity.git", branch: "main"
  license "MIT"

  depends_on "go" => :build

  depends_on "beads"
  depends_on "jq"
  depends_on "tmux"

  on_macos do
    depends_on "flock"
  end

  def install
    system "go", "build",
           "-ldflags", "-X main.version=HEAD",
           "-o", bin/"gc",
           "./cmd/gc"
  end

  def caveats
    <<~EOS
      Gas City depends on these runtime tools, installed as dependencies:
        beads (bd)  - issue tracker
        dolt        - beads storage (via beads)
        flock       - file locking
        jq          - JSON processing
        tmux        - session management

      Get started:
        gc init <city-path>      # create a new city
        gc start <city-path>     # start an existing city
    EOS
  end

  test do
    assert_match "HEAD", shell_output("#{bin}/gc version")
  end
end
