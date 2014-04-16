module ArpScan
  require 'open3'

  IP_ADDRESS_REGEX = /\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\Z/

  MAC_ADDRESS_REGEX = /([0-9A-F]{2}[:]){5}([0-9A-F]{2})/i

  def self.fetch(ip_address, interface)
    raise 'Must run as root' unless Process.uid == 0
    raise 'invalid IP address' unless ip_address =~ IP_ADDRESS_REGEX
    cmd = "arp-scan -l -s #{ip_address} -I #{interface} -q"
    addresses = []
    Open3.popen3(cmd) do |stdin, stdout, sterr, wait_thr|
      stdout.each_line do |line|
        addresses << extract_mac_address(line)
      end
    end
    addresses.delete_if{ |a| a.nil? }.uniq!
  end

  def self.extract_mac_address(str)
    str.match(MAC_ADDRESS_REGEX) { |m| m }
  end
end
