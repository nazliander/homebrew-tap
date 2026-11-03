class Hooktop < Formula
  desc "Live view of Claude Code tool calls, subagents and CPU/RAM use"
  homepage "https://github.com/nazliander/hooktop"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.3/hooktop-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "03893d35ad69f36f23864f7d3841dbeb6fd64c27f6ed76d794ab702fbc13a7ba"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.3/hooktop-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "8623bb82fb61e1ad177d7f3c26e33c7115e6d979ffdfec1483f41d7b48a60ca0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.3/hooktop-v0.1.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9743b9d8dbe112f7bb1ce8062953eee6f841a46a5760ddacf2bde712ae7006eb"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.3/hooktop-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ddd93c75c7ccc78bed4035940dd6288b28c0a5527a90e857a2e4e90afe6936e2"
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
