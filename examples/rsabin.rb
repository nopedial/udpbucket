#!/usr/bin/env ruby

require 'udpbucket'

begin
  cfg = { :localhost => '::', :localport => 53, :debug => 1 }
  udpbucket = UDPBucket::Core.new cfg
  udpbucket.listen do |pkt_hash|
    puts pkt_hash[:payload]
  end
end  
