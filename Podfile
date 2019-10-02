platform :ios, '9.0'

target 'Youth' do
  use_frameworks!
  inhibit_all_warnings!

  # Reactive
  pod 'RxSwift'
  pod 'RxCocoa'

  # Networking
  pod 'Alamofire'
  pod 'Moya'

  # Image Plugin
  pod 'AlamofireImage'
  pod 'SDWebImage/Core'

  # Layout
  pod 'SnapKit'

  # Custom Segmented Control
  pod 'PinterestSegment'

  # Custom Downloading Button
  pod 'DownloadButton'

  # Permissions
  pod 'Permission/Photos'

  # Reusable
  pod 'Reusable'
 
  # Custom Notifications
  pod 'SwiftMessages'

  target 'YouthTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end

    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          if target.name == 'Permission'
            config.build_settings['SWIFT_VERSION'] = '4.1'
          end
        end
    end
end
