Pod::Spec.new do |s|
  s.name             = "R-OC"
  s.version          = "0.0.1"
  s.summary          = "资源索引框架"
  s.description      = '可方便的使用代码方式获取到工程中所有资源文件，包含（图片，xib，file等）'
  s.homepage         = "https://github.com/mr-loney/R.oc.git"
  s.license =  { :type => 'BSD' }
  s.source   = { :git => 'R-OC', :tag => s.version }
  s.author           = { "pengjun" => "mr_lonely@foxmail.com" }
  s.platform     = :ios, '8.0'
  s.prepare_command = 'ruby R-OC/BundleR.rb'


  #'ruby R-OC/BundleR.rb "${PROJECT_NAME}"'


  #'ruby BundleR.rb "${PROJECT_NAME}"'

  s.default_subspec = 'Source'
  s.subspec 'Source' do |spec|
      spec.prefix_header_file = 'TinyVideo/TinyVideo-Prefix.pch'
      spec.requires_arc        = true
      spec.source_files = [
        'R-OC/R.{h,m}',
        'R-OC/RImage.{h,m}',
        'R-OC/RStoryboard.{h,m}',
        'R-OC/RXib.{h,m}',

        'R-OC/**/*.h'
      ]
  end
end
