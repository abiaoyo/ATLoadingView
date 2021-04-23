Pod::Spec.new do |s|

s.name         = "ATLoadingView"
s.version      = "0.1"
s.summary      = ""
s.homepage     = "https://github.com/abiaoyo/ATLoadingView"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "abiaoyo" => "347991555@qq.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/abiaoyo/ATLoadingView.git", :tag => s.version }
s.source_files = "ATLoadingView/**/*.{h,m}"
s.resource     = "ATLoadingView/Resources/ATLoadingView.bundle"
s.requires_arc = true
s.frameworks = "Foundation","UIKit"

end
