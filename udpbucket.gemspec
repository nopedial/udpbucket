Gem::Specification.new do |s|
  s.name              = 'udpbucket'
  s.version           = '0.1.0'
  s.platform          = Gem::Platform::RUBY
  s.authors           = [ 'Samer Abdel-Hafez' ]
  s.email             = %w( sam@arahant.net )
  s.homepage          = 'http://github.com/nopedial/udpbucket'
  s.summary           = 'udp bucket'
  s.description       = 'a lightweight udp server'
  s.rubyforge_project = s.name
  s.files             = `git ls-files`.split("\n")
  s.executables       = %w( )
  s.require_path      = 'lib'

  s.add_dependency 'json'
  s.add_dependency 'asetus', '>= 0.0.7'
  s.add_dependency 'logger', '>= 1.2.8'
end
