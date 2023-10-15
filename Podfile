# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'MovieGuide' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MovieGuide
pod 'Gemini'
pod 'Google-Mobile-Ads-SDK'
pod 'FirebaseMessaging'
pod 'FirebaseAuth'
pod 'Alamofire', '~> 5.8'
pod 'SDWebImage', '~> 5.18'
pod 'ProgressHUD', '~> 14.0'
end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end