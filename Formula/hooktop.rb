class Hooktop < Formula
  desc "Live view of Claude Code tool calls, subagents and CPU/RAM use"
  homepage "https://github.com/nazliander/hooktop"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.0/hooktop-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "0aabbde878134342ee32325a76bae262883cd07f5b9708545e411b4d38bf31e9"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.0/hooktop-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "02aecb894abda08180acfa5d6dd25cb89b00e952ce83e8468d9decbc2db75b71"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.0/hooktop-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ca4b5ec2add13c4c0a9096004a092cf84a531638682e97322cd9f352df26bfc2"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.0/hooktop-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed50a95b1d065fe4d4d8ece0a91ce9dacf89c4b1a63fb44c45bc5b1caf4c0251"
    end
  end

  def install
    bin.install "hooktop"
  end

  # `brew services start hooktop` keeps the server up, so every Claude Code
  # session is recorded even when no hooktop window is open. It's meant to
  # stay up, so the idle timeout is off.
  service do
    run [opt_bin/"hooktop", "serve", "--idle-timeout", "off"]
    keep_alive true
    log_path var/"log/hooktop.log"
    error_log_path var/"log/hooktop.log"
  end

  def caveats
    <<~EOS
      Point Claude Code at hooktop once:
        hooktop hooks install

      Then run `hooktop`. To keep recording sessions when no hooktop window
      is open:
        brew services start hooktop
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hooktop --version")
  end
end
