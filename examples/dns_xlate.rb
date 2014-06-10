#!/usr/bin/env ruby

require 'udpbucket'

resolver = '8.8.8.8'

begin
  cfg = { :localhost => '::', :localport => 53, :debug => 1 }
  udpbucket = UDPBucket::Core.new cfg
  udpbucket.listen do |pkt_hash|
    out_sock = UDPSocket.new
    r = Random.new
    sport = r.rand(1024..65535)
    out_sock.bind '0.0.0.0', sport
    udpbucket.debug "forwarding request to resolver : #{resolver}:53" if cfg[:debug] == 1
    out_sock.send pkt_hash[:payload], 0, resolver, 53
    reply, _ = out_sock.recvfrom(1500)
    re_hash = { :resolver_ip => resolver, :reply => reply }
    udpbucket.debug "reply received : #{re_hash}" if cfg[:debug] == 1
    pkt_hash[:client_sock].send reply, 0, pkt_hash[:client_ip], pkt_hash[:client_port]
    out_sock.close
    udpbucket.debug "translation completed"  if cfg[:debug] == 1
  end
end
