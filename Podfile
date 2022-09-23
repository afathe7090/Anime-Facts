# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'Anime-Facts' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Anime-Facts

pod 'RxSwift', '6.5.0'
pod 'RxCocoa', '6.5.0'
pod 'Moya/RxSwift', '~> 15.0'
pod 'RxDataSources', '~> 5.0'
pod "Resolver"
pod 'SkeletonView'
pod 'SnapKit'
pod 'Kingfisher', '~> 7.0'

end



post_install do |pi|
   pi.pods_project.targets.each do |t|
       t.build_configurations.each do |bc|
           if bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '12.0'
             bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
           end
       end
   end
end
