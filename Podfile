platform :ios, '9.0'

target 'Youth' do
  use_frameworks!

  inhibit_all_warnings!

  # Pods for Youth

  # Networking
  pod 'Alamofire'

  # Image Plugin
  pod 'AlamofireImage'

  # Resources code generation
  pod 'R.swift'

  # Layout
  pod 'SnapKit'

  # Custom Segmented Control
  pod 'PinterestSegment'

  # Custom Downloading Button
  pod "DownloadButton"

  # Permissions
  pod 'Permission/Photos'
 
  # Custom Notifications
  pod 'SwiftMessages'

  # Crash Logs
  pod 'Fabric'
  pod 'Crashlytics'

  target 'YouthTests' do
    inherit! :search_paths
    # Pods for testing

  end

  target 'YouthUITests' do
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
end
