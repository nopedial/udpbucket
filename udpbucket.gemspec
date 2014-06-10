Gem::Specification.new do |s|
  s.name              = 'udpbucket'
  s.version           = '0.0.8'
  s.platform          = Gem::Platform::RUBY
  s.authors           = [ 'Samer Abdel-Hafez' ]
  s.email             = %w( sam@arahant.net )
  s.homepage          = 'http://github.com/nopedial/udpbucket'
  s.summary           = 'udp bucket'
  s.description       = 'a lightweight udp server'
  s.rubyforge_project = s.name
  s.files             = ["lib/udpbucket.rb", "lib/udpbucket/core.rb"]
  s.executables       = %w( )
  s.require_path      = 'lib'

  s.add_dependency 'json'
end