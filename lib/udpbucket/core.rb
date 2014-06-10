module UDPBucket
  class Core

    def initialize cfg
      @cfg              = cfg
      @debug            = @cfg[:debug]
      @localhost        = @cfg[:localhost] || '0.0.0.0'
      @localport        = @cfg[:localport] || 16265
      @rx_queue         = Queue.new
      if IPAddr.new(@localhost).ipv6?
        @sock           = UDPSocket.new Socket::AF_INET6
      else
        @sock           = UDPSocket.new
      end
      @sock.bind @localhost, @localport
      debug "udpbucket server up: #{@localhost}:#{@localport}" if @debug == 1
    end

    def debug msg
      puts [ "D, [#{Time.now} ", [ "#", "#{Process.pid}" ].join, "] DEBUG -- ", msg ].join 
    end

    def listen
      queue = Thread.new do
        while true do
          r, w, e = IO.select([@sock], nil, nil)
          if r[0]
            buffer, sockaddr = @sock.recvfrom_nonblock(1500)
            pkt = { :client_sock => @sock, :client_ip => sockaddr[3], :client_port => sockaddr[1], :payload => buffer }
	    @rx_queue << pkt
            debug "packet queued (queue size:#{@rx_queue.size}): #{pkt}" if @debug == 1
          end
        end
      end
      consumer = Thread.new do
        while true do
          begin
            yield @rx_queue.pop
            debug "yield to block (queue size:#{@rx_queue.size})" if @debug == 1
          end
        end
      end
      consumer.join
    end

  end
end
