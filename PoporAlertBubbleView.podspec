#
# Be sure to run `pod lib lint PoporAlertBubbleView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name     = 'PoporAlertBubbleView'
    s.version  = '1.02'
    s.summary  = '类似iPhone 的 UIMenuController,将自定义view以气泡包围的方式展示出来,假如设置的方向不正确则自动使用其他方向.'
    
    s.homepage = 'https://github.com/popor/PoporAlertBubbleView'
    s.license  = { :type => 'MIT', :file => 'LICENSE' }
    s.author   = { 'popor' => '908891024@qq.com' }
    s.source   = { :git => 'https://github.com/popor/PoporAlertBubbleView.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '8.0'
    s.source_files = 'PoporAlertBubbleView/Classes/*.{h,m}'
    
end
