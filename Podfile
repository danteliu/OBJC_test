platform :ios, '11.0'
inhibit_all_warnings! # 强制忽略警告信息

# 添加一个额外的约束条件来限制所有库的版本
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end

# source 'https://github.com/CocoaPods/Specs.git'
target 'OBJC_test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  pod 'HBDNavigationBar', '~> 1.8.4'#导航栏
  pod 'SDCycleScrollView', '~> 1.82'#轮播控件
  pod 'AFNetworking', '~> 4.0.1'#网络组件
  pod 'Masonry', '~> 1.1.0'#布局
  pod 'NerdyUI', '~> 1.2.1'
  pod 'RBDateTime', '~> 0.1'#日期时间处理
  pod 'MBProgressHUD', '~> 1.1.0'
  pod 'MJExtension', '~> 3.2.1'#模型转字典
  pod 'PrintBeautifulLog', '~> 1.0.0'#控制台打印字典
  pod 'Aspects', '~> 1.4.1'#面向切面编程(AOP埋点)
  pod 'JKCategories', '~> 1.9.3'#jk 分类
  pod 'pop', '~> 1.0.12'#facebook 动画库
  pod 'WMZBanner', '~> 1.2.0'#渐进轮播
  pod 'SDWebImage', '~> 5.12.6'#图片缓存框架
  target 'OBJC_testTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'OBJC_testUITests' do
    # Pods for testing
  end
  
end
