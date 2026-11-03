class Hooktop < Formula
  desc "Live view of Claude Code tool calls, subagents and CPU/RAM use"
  homepage "https://github.com/nazliander/hooktop"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.4/hooktop-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "add3bbf023951f0113ea53b8174e72566b3527bdc30ae21c3a821ad3844d9c9b"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.4/hooktop-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "eeee09355c62dc4fc339c2ec9b25e449a1aaa4e2a503cb33ecca3fac469e5e01"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.4/hooktop-v0.1.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "98758048473e7b8504d5993a23e158d6148af6e23030299838df249d3b6e772e"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.4/hooktop-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b45b4470b64ba7d100bca6688ba7c7551167dcfc5ba4c71c2afca9585686ff6a"
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
