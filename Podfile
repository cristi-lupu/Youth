platform :ios, '9.0'

target 'Youth' do
  use_frameworks!

  inhibit_all_warnings!

  # Pods for Youth

  # Networking
  pod 'Alamofire', '~> 4.7.3'

  # Image Plugin
  pod 'AlamofireImage', '~> 3.4.1'

  # Layout
  pod 'SnapKit', '~> 4.0.1'

  # Custom Segmented Control
  pod 'PinterestSegment', '~> 1.2'

  # Custom Downloading Button
  pod 'DownloadButton', '~> 0.1'

  # Permissions
  pod 'Permission/Photos', '~> 2.0.4'
 
  # Custom Notifications
  pod 'SwiftMessages', '~> 6.0'

  # Crash Logs
  pod 'Fabric', '~> 1.7.11'
  pod 'Crashlytics', '~> 3.10.7' 

  target 'YouthTests' do
    inherit! :search_paths
    # Pods for testing

  end
end

# Workaround for Cocoapods issue #7606  https://github.com/CocoaPods/CocoaPods/issues/7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end

    installer.pods_project.targets.each do |target|
        if target.name == 'Permission' || target.name == 'PinterestSegment' 
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.1'
            end
        end
    end
end