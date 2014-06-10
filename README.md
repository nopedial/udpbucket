## UDPBucket

A simple UDP server library using working queue.

## requirements

+ ruby 1.9.3+
+ json
+ asetus 0.0.7+
+ logger 1.2.8+

## install

	> gem install udpbucket
	>

## packets

UDPBucket returns to a block each packet it receives to the listening UDP port formatted in a standard hash.

## hash format

	{ :client_sock => <socket_object>, 
	  :client_ip => 'x.x.x.x', 
	  :client_port => xxxxx, 
	  :payload => '\x00\xFF\xFF' }

## example:

	require 'udpbucket'

	begin
	  cfg = { :localhost => '0.0.0.0', :localport => 1024, :debug => 0 }
	  udpbucket = UDPBucket::Core.new cfg
	  udpbucket.listen do |req|
	    if req[:payload] == '\x00\xFF\xFF'
	      req[:client_sock].send '<..some payload..>', 0, req[:client_ip], req[:client_port]
              udpbucket.debug "reply sent to client: #{req[:client_ip]}:#{req[:client_port]}" if cfg[:debug] == 1
	    end
	  end
	end

## configuration:

The configuration is loaded at the start via Asetus. If the configuration is not passed to the 'Core' class, Asetus will load the default set (localhost:0.0.0.0,localport:16265,debug:1)
