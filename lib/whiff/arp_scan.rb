module Whiff
  module ArpScan

    IP_ADDRESS_REGEX = /\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\Z/

    MAC_ADDRESS_REGEX = /([0-9A-F]{2}[:]){5}([0-9A-F]{2})/i

    def self.fetch(ip_address, interface, options={})
      raise 'Must run as root' unless Process.uid == 0
      raise 'arp-scan not installed' unless arp_scan_installed?
      raise 'invalid IP address' unless ip_address =~ IP_ADDRESS_REGEX
      cmd = "arp-scan -l -s #{ip_address} -I #{interface} -q"
      addresses = []
      stdout = `#{cmd}`
      stdout.each_line do |line|
        addresses << extract_mac_address(line)
      end
      addresses.delete_if{|a| a.nil?}.uniq!
      puts addresses if options[:verbose]
      addresses
    end

    def self.extract_mac_address(str)
      str.match(MAC_ADDRESS_REGEX) { |m| m }
    end

    def self.arp_scan_installed?
      `which arp-scan`
      $?.success?
    end
  end
end
