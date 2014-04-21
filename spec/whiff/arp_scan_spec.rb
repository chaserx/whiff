require "spec_helper"

module Whiff::ArpScan
  describe "fetching MAC addresses through arp-scan" do
    let(:bin_dir) { File.join('spec', 'data', 'bin') }
    let(:path_env) { File.expand_path(bin_dir) }
    let(:env) { "PATH=#{path_env}:$PATH" }

    it "returns an array" do
      output = Whiff::ArpScan.fetch('10.0.1.1', 'en1', test: true, env: env)
      expect(output.class).to eq(Array)
    end

    it "returns MAC address from output" do
      def output
        <<-OUTPUT.gsub(/^ {4}/, '')
          Interface: en1, datalink type: EN10MB (Ethernet)
          Starting arp-scan 1.8 with 256 hosts (http://www.nta-monitor.com/tools/arp-scan/)
          10.0.1.7  b8:8d:12:59:43:b9
          10.0.1.29 00:13:21:c1:28:9a

          519 packets received by filter, 0 packets dropped by kernel
          Ending arp-scan 1.8: 256 hosts scanned in 1.176 seconds (217.69 hosts/sec). 2 responded
        OUTPUT
      end

      expect(Whiff::ArpScan.extract_mac_address(output)[0]).to include("b8:8d:12:59:43:b9")
    end

    it "returns an array of MAC addresses" do
      output = Whiff::ArpScan.fetch('10.0.1.1', 'en1', test: true, env: env)
      expect(output.size).to be > 0
      expect(output[0].to_s).to match(MAC_ADDRESS_REGEX)
    end
  end
end
