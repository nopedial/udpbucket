module UDPBucket
  class Core
    require 'asetus'

    def initialize usercfg
      cfgs = Asetus.new :name=>'udpbucket', :load=>false
      cfgs.default.debug      = usercfg[:debug] || 1
      cfgs.default.localhost  = usercfg[:localhost] || '0.0.0.0'
      cfgs.default.localport  = usercfg[:localport] || 16265
      cfgs.load
      @cfg = cfgs.cfg
      load
    end

    def load
      @rx_queue         = Queue.new
      if IPAddr.new(@cfg.localhost).ipv6?
        @sock           = UDPSocket.new Socket::AF_INET6
      else
        @sock           = UDPSocket.new
      end
      @sock.bind @cfg.localhost, @cfg.localport
      Log.debug "udpbucket server up: #{@cfg.localhost}:#{@cfg.localport}" if @cfg.debug == 1
    end

    def listen
      queue = Thread.new do
        while true do
          r, w, e = IO.select([@sock], nil, nil)
          if r[0]
            buffer, sockaddr = @sock.recvfrom_nonblock(1500)
            pkt = { :client_sock => @sock, :client_ip => sockaddr[3], :client_port => sockaddr[1], :payload => buffer }
	    @rx_queue << pkt
            Log.debug "packet queued (queue size:#{@rx_queue.size}): #{pkt}" if @cfg.debug == 1
          end
        end
      end
      consumer = Thread.new do
        while true do
          begin
            yield @rx_queue.pop
            Log.debug "yield to block (queue size:#{@rx_queue.size})" if @cfg.debug == 1
          end
        end
      end
      consumer.join
    end

  end
end
