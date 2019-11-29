# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def rxPods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxRealm'
end

def apiPods
  pod 'Moya', '14.0.0-alpha.1'
  pod 'Moya/RxSwift', '14.0.0-alpha.1'
  pod 'Alamofire'
  pod 'Nuke'
end


target 'lydiaApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods to integrate
  rxPods
    apiPods
  
  target 'lydiaAppTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxTest'
  end
end
