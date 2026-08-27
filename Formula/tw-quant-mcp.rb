# 自動產生：由 tw-quant-mcp release workflow 於 2.2.0 發佈時更新，請勿手改。
class TwQuantMcp < Formula
  desc "Taiwan quant market data MCP Server (official sources)"
  homepage "https://github.com/gentoobreaking/tw-quant-mcp"
  version "2.2.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gentoobreaking/tw-quant-mcp/releases/download/v2.2.0/tw-quant-mcp_v#{version}_darwin_arm64.tar.gz"
      sha256 "9d9b728f6d1ae4d45193f355c0df88ba6efccdc055d8f1277481930846674c71"
    else
      url "https://github.com/gentoobreaking/tw-quant-mcp/releases/download/v2.2.0/tw-quant-mcp_v#{version}_darwin_amd64.tar.gz"
      sha256 "e3c20e3aa69e353c1f893bb19a434c14f652488e9eede9833de5765c1baa5a04"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gentoobreaking/tw-quant-mcp/releases/download/v2.2.0/tw-quant-mcp_v#{version}_linux_arm64.tar.gz"
      sha256 "e4e332f770b1274571ade0fb670e8ac4630e7cb2f312186b5a2cc6300140d5f8"
    else
      url "https://github.com/gentoobreaking/tw-quant-mcp/releases/download/v2.2.0/tw-quant-mcp_v#{version}_linux_amd64.tar.gz"
      sha256 "ad6ab583488276ff2fbec7274a2234d6a83a6e43f5e8ca2bb5b6d333fcdde726"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "tw-quant-mcp_v#{version}_#{os}_#{arch}" => "tw-quant-mcp"
  end

  def caveats
    <<~CAVEATS
      MCP stdio server. Point your MCP client to:
        #{HOMEBREW_PREFIX}/bin/tw-quant-mcp

      Example (Claude Desktop):
        { "mcpServers": { "tw-quant-mcp": { "command": "#{HOMEBREW_PREFIX}/bin/tw-quant-mcp" } } }
    CAVEATS
  end

  test do
    require "open3"
    input = '{"jsonrpc":"2.0","id":1,"method":"initialize",'             '"params":{"protocolVersion":"2025-03-26","capabilities":{},'             '"clientInfo":{"name":"brew-test","version":"1"}}}'
    out, err, status = Open3.capture3(bin/"tw-quant-mcp", stdin_data: input + "\n")
    assert status.success?, "tw-quant-mcp exited abnormally: #{err}"
    assert_match %r{serverInfo}m, out, "initialize 回應應含 serverInfo"
  end
end
