# 自動產生：由 tw-quant-mcp release workflow 於 2.1.0 發佈時更新，請勿手改。
class TwQuantMcp < Formula
  desc "Taiwan quant market data MCP Server (official sources)"
  homepage "https://github.com/gentoobreaking/tw-quant-mcp"
  version "2.1.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gentoobreaking/tw-quant-mcp/releases/download/v2.1.0/tw-quant-mcp_v#{version}_darwin_arm64.tar.gz"
      sha256 "cb714163d948bcaa4960a7c435640f09b102e4c73cadf8480bb912725478ce97"
    else
      url "https://github.com/gentoobreaking/tw-quant-mcp/releases/download/v2.1.0/tw-quant-mcp_v#{version}_darwin_amd64.tar.gz"
      sha256 "861e2cc082db2d1621d9d3a3479f151b7c8b8790718e28bd264e4f6e08094bce"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gentoobreaking/tw-quant-mcp/releases/download/v2.1.0/tw-quant-mcp_v#{version}_linux_arm64.tar.gz"
      sha256 "267cdb2b94cbb62e4a3c91f0a8599b8b9a8785cb9861beb46284e3a53892ce03"
    else
      url "https://github.com/gentoobreaking/tw-quant-mcp/releases/download/v2.1.0/tw-quant-mcp_v#{version}_linux_amd64.tar.gz"
      sha256 "80ed54deb1bd3fcc6f0ad1a9a4809166047c7a83b192b6e640bb7d9a6e76840d"
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
