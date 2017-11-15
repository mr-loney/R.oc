Pod::Spec.new do |s|
  s.name             = "R-OC"
  s.version          = "0.0.2"
  s.summary          = "资源索引框架"
  s.description      = '可方便的使用代码方式获取到工程中所有资源文件，支持xib,storyboard,img,file,xcasset等格式'
  s.homepage         = "https://github.com/mr-loney/R.oc.git"
  s.license =  { :type => 'BSD' }
  s.source   = { :git => 'https://github.com/mr-loney/R.oc.git', :tag => s.version }
  s.author           = { "pengjun" => "mr_lonely@foxmail.com" }
  s.platform      = :ios, '8.0'
  # rm -rf R-OC/R-OC/RBundle.*
  s.prepare_command = <<-CMD
                        chmod a+w R-OC/R-OC/RBundle.*
                        chmod a+w R-OC/R-OC/RImage.*
                        chmod a+w R-OC/R-OC/RXib.*
                        chmod a+w R-OC/R-OC/RStoryboard.*
                        chmod a+w R-OC/R-OC/RFile.*
                   CMD
  # s.prepare_command = <<-CMD
  #                       current_pwd="$PWD"
  #                       project_dir=`cd "../../"; pwd`
  #                       cd "$current_pwd"
  #
  #                       project_file=`find "$project_dir" -maxdepth 1 -name "*.xcodeproj" | tail -1`
  #
  #                       /usr/bin/ruby R-OC/R-OC/set_project_run_script.rb $project_dir
  #                  CMD
  # s.prepare_command = "/usr/bin/ruby R-OC/R-OC/set_project_run_script.rb"
  s.prefix_header_file = 'R-OC/R-OC/R-OC-Prefix.pch'
  s.source_files = "R-OC/R-OC/**/*.{h,m,rb}"
  s.frameworks    = [
    "UIKit"
  ]
end
