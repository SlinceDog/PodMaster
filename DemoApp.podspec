Pod::Spec.new do |s|
  s.name         = "DemoApp"
  s.homepage     = "https://github.com/SlinceDog/PodMaster.git"
  s.summary      = "A marquee view used on iOS."
  s.author       = { "Slinece" => "wyt328412339@126.com" }
  s.version      = "0.1.0"
  s.source       = { :git => "https://github.com/SlinceDog/PodMaster.git", :tag => s.version.to_s }
  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.license      = 'MIT'
  s.source_files = 'MyCustomView/*.{h,m}'
# s.resource     = 'CMBCSDK/bundle/*.{png,nib,bundle}'
# s.vendored_libraries  = 'CMBCSDK/CMBCResource/CMBCPasswordControl/libSIPInputBox.a','CMBCSDK/CMBCResource/UPPayPlugin/libUPPayPlugin.a','CMBCSDK/CMBCP2PLib/libP2P.a'
  s.frameworks   = 'UIKit', 'Foundation', 'CFNetwork', 'SystemConfiguration', 'Security', 'QuartzCore', 'CoreGraphics', 'AudioToolbox'

end
