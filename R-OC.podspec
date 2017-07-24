Pod::Spec.new do |s|
  s.name             = "R-OC"
  s.version          = "0.0.1"
  s.summary          = "资源索引框架"
  s.description      = '可方便的使用代码方式获取到工程中所有资源文件，包含（图片，xib，file等）'
  s.homepage         = "https://github.com/mr-loney/R.oc.git"
  s.license =  { :type => 'BSD' }
  s.source   = { :git => 'https://github.com/mr-loney/R.oc.git', :tag => s.version }
  s.author           = { "pengjun" => "mr_lonely@foxmail.com" }
  s.platform      = :ios, '8.0'
  # s.vendored_frameworks = "Output/ROC.framework"
  s.prefix_header_file = 'R-OC/R-OC/R-OC-Prefix.pch'
  s.source_files = "R-OC/R-OC/*.{h,m}"
  s.frameworks    = [
    "UIKit"
  ]
end
