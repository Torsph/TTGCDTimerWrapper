Pod::Spec.new do |s|
  s.name         = 'TTGCDTimerWrapper'
  s.version      = '0.1'
  s.license      = 'MIT'
  s.summary      = 'A wrapper of the GCDs dispatch_source to use instead of NSTimer'
  s.homepage     = 'https://github.com/Torsph/TTGCDTimerWrapper'
  s.author       = { 'Thomas Torp' => 'nexz_87@hotmail.com' }
  s.source       = { 
  			:git => 'https://github.com/Torsph/TTGCDTimerWrapper.git',
  			:tag => '0.1'
  }
  s.source_files = 'TTGCDTimerWrapper.{h,m}'
  s.requires_arc = true
end
