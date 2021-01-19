

Pod::Spec.new do |spec|

  spec.name         = "TTBinary"
  spec.version      = "1.0"
  spec.summary      = "TTBinary二进制"
  spec.description  = "TTBinary二进制"
  spec.homepage     = "http://git.guazi-corp.com/"
  spec.license      = "private"
  spec.author       = { "zx" => "zhux@gi.com" }
  spec.source       = { :git => ".", :tag => "#{spec.version}" }
  spec.source_files = "TTBinary", "TTBinary/**/*.{h,m}"
  spec.platform     = :ios,'9.0'
  spec.pod_target_xcconfig = {'USE_HEADERMAP' => false}

end
