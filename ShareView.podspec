Pod::Spec.new do |s|
  s.name         = "ShareView"
  s.version      = "0.0.1"
  s.summary      = "一款简单的类似微信的分享的自定义的视图"
  s.description  = <<-DESC
  一款简单的类似微信的分享的自定义的视图，集成了CocoaPods
                   DESC
  s.homepage     = "https://github.com/speeddream/ShareView"
  s.license      = "MIT"
  s.author             = { "zhaoqiang" => "zhaoqiang@hairuncf.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/speeddream/ShareView.git", :tag => s.version }
  s.source_files  = "ShareView/**/*.h"
  s.requires_arc = true
end
