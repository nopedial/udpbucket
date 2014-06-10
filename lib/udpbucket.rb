module UDPBucket
 Directory = File.expand_path File.join File.dirname(__FILE__), '../'
 require 'json'
 require 'socket'
 require 'thread'
 require 'ipaddr'
 require 'udpbucket/log'
 require 'udpbucket/core'
end
