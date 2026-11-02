class Hooktop < Formula
  desc "Live view of Claude Code tool calls, subagents and CPU/RAM use"
  homepage "https://github.com/nazliander/hooktop"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.1/hooktop-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "43ea5faec121bf7ea117e991203b2eebd2f76b8149e0bb7416135917e9631612"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.1/hooktop-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "9953636e5e3239ad676213c5b5e526af1bc67a0eeb102e5ec7aba3135d024f80"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.1/hooktop-v0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "802dfe6190cca8a37981ee32c35cb54ac5acfd6f62f854306b616de81bf11912"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.1/hooktop-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ad96f8d40082e317ff638926687533a5761f767c84955878348518094eb3bf57"
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
