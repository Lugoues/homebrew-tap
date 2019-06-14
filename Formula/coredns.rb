require "language/go"

class Coredns < Formula
  desc "DNS server that chains plugins"
  homepage "https://coredns.io"
  # url "https://github.com/coredns/coredns/archive/v1.5.0.tar.gz"
  # sha256 "69d9a7df50ecb8cc44656064537927e2abd5ff5d6b82de067e6328723b81efe3"
  head "https://github.com/coredns/coredns.git", :tag => "v1.5.0"

  def default_coredns_config; <<~EOS
    . {
      hosts {
        fallthrough
      }
      proxy . 8.8.8.8:53 8.8.4.4:53 {
        protocol https_google
      }
      cache
      errors
    }
    EOS
  end

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = "amd64"
    ENV["BUILDOPTS"] = ""
    ENV["CHECKS"] = ""

    (buildpath/"src/github.com/coredns/coredns").install buildpath.children

    cd "src/github.com/coredns/coredns" do
      system "make", "coredns", "BINARY=#{sbin}/coredns"
    end

    (buildpath/"Corefile.example").write default_coredns_config
    (etc/"coredns").mkpath
    etc.install "Corefile.example" => "coredns/Corefile"
  end

  def caveats; <<~EOS
    To configure coredns, take the default configuration at
    #{etc}/coredns/Corefile and edit to taste.

    By default it is configured to proxy all dns requests
    through Google's DNS-over-HTTPS:
    (https://developers.google.com/speed/public-dns/docs/dns-over-https).
    EOS
  end

  plist_options :startup => true

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
    <string>#{opt_sbin}/coredns</string>
    <string>-conf</string>
    <string>#{etc}/coredns/Corefile</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>#{var}/log/coredns.log</string>
    <key>StandardOutPath</key>
    <string>#{var}/log/coredns.log</string>
    <key>WorkingDirectory</key>
    <string>#{HOMEBREW_PREFIX}</string>
    </dict>
    </plist>
    EOS
  end

  test do
    assert_match "CoreDNS-#{version}", shell_output("#{sbin}/coredns -version")
  end
end
