## UDPBucket

A simple UDP server library

## requirements

+ ruby 1.9+

## install

	> gem install udpbucket
	>

## yield to block

Udpbucket yields the UDP packets received from the listening port to a block, formatted into a standard hash.

## hash format

	{ :client_sock => <socket_object>, 
	  :client_ip => 'x.x.x.x', 
	  :client_port => xxxxx, 
	  :payload => '\x00\xFF\xFF' }

## example:

	require 'udpbucket'

	begin
	  cfg = { :localhost => '0.0.0.0', :localport => 1024, :debug => 1 }
	  udpbucket = UDPBucket::Core.new cfg
	  udpbucket.listen do |req|
	    if req[:payload] == '\x00\xFF\xFF'
	      req[:client_sock].send '<..some payload..>', 0, req[:client_ip], req[:client_port]
              udpbucket.debug "reply sent to client: #{req[:client_ip]}:#{req[:client_port]}" if cfg[:debug] == 1
	    end
	  end
	end

