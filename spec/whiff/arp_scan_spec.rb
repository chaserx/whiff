require "spec_helper"

class BackTicks
  attr_accessor :ip_address, :interface

  def run
    `arp-scan -l -s #{ip_address} -I #{interface} -q`
  end
end

module Whiff::ArpScan
  describe "fetching MAC addresses through arp-scan" do
    subject { BackTicks.new }

    let(:ip_address) { '10.0.1.1' }
    let(:interface) { 'en1' }

    it "should execute arp scan with params" do
      pending "not sure how to mock out backticks"
      cmd = "arp-scan -l -s #{ip_address} -I #{interface} -q"
      subject.should_receive(:`).with(cmd).and_return(["00:13:21:c1:28:9a"])
    end
  end
end
