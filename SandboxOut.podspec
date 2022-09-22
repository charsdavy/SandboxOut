Pod::Spec.new do |s|
  s.name         = "SandboxOut"
  s.version      = "0.1.1"
  s.summary      = "Quickly browse the iOS sandbox data in the App and perform operations."
  s.homepage     = "https://github.com/charsdavy/SandboxOut"
  s.license      = 'MIT'
  s.authors      = [ "chars.davy" => "chars.davy@gmail.com" ]
  s.source       = { :git => "git@github.com:charsdavy/SandboxOut.git", :tag => s.version.to_s }
  s.ios.deployment_target = "11.0"
  s.source_files = 'SandboxOut/*.{h,m}'
  s.public_header_files = 'SandboxOut/*.h'
  s.static_framework = false
end