class Hooktop < Formula
  desc "Live view of Claude Code tool calls, subagents and CPU/RAM use"
  homepage "https://github.com/nazliander/hooktop"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.2/hooktop-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "de520a764ae325babdabd75bedce1faf253926a254569948296cbdb2e1fdb900"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.2/hooktop-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "ab4186b89b9705feff6dc7220104b6d1e05c0a23cf6716e78154729a67340b06"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.2/hooktop-v0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "349755453902f34396008eab546a8df9faf5b4b68c499fd7ccf0269b9eaf65a3"
    end
    on_intel do
      url "https://github.com/nazliander/hooktop/releases/download/v0.1.2/hooktop-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa5ad0576de2452c282d34e69099d3aa845cf971a127373ed1ac9025304a0dcd"
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
