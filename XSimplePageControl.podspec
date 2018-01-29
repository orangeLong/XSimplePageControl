Pod::Spec.new do |s|

  s.name       		= "XSimplePageControl"
  s.version   		= "0.0.1"
  s.summary      	= "simplePageControl"
  s.description  	= "一个带简单动画的自定义pageControl"
  s.homepage     	= "https://github.com/orangeLong"
  s.license 		= { :type => 'MIT', :file => 'LICENSE' }
  s.author       	= { "Lixinlong" => "lixinlong@xkshi.com" }
  s.platform     	= :ios, "8.0"
  s.source       	= { :git => "https://github.com/orangeLong/XSimplePageControl.git", :tag => s.version.to_s }
  #s.source       	= { :git => "git@github.com:orangeLong/XSimplePageControl.git", :tag => s.version.to_s }
  s.source_files = "XSimplePageControl/XSimplePageControl/**/*.{h,m}"
  s.public_header_files = "XSimplePageControl/XSimplePageControl/**/*.h"
end
