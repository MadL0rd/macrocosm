//
// Auto generated file
//

import UIKit

protocol ModuleGenerator {
    func createModule() -> UIViewController
}

enum UserStoriesModulesDefault: ModuleGenerator {

    case settings
    case aboutUs
    case loading
    case today
    case general
    case locationPickerContainer
    case userInfoEditor
    case main

    func createModule() -> UIViewController {
        switch self {
        case .settings: 
            return SettingsCoordinator.createModule()
        case .aboutUs: 
            return AboutUsCoordinator.createModule()
        case .loading: 
            return LoadingCoordinator.createModule()
        case .today: 
            return TodayCoordinator.createModule()
        case .general: 
            return GeneralCoordinator.createModule()
        case .locationPickerContainer: 
            return LocationPickerContainerCoordinator.createModule()
        case .userInfoEditor: 
            return UserInfoEditorCoordinator.createModule()
        case .main: 
            return MainCoordinator.createModule()
        }
    }
}

enum UserStoriesModulesWithOutput: ModuleGenerator {

    case settings(output: SettingsOutput)
    case aboutUs(output: AboutUsOutput)
    case loading(output: LoadingOutput)
    case today(output: TodayOutput)
    case general(output: GeneralOutput)
    case locationPickerContainer(output: LocationPickerContainerOutput)
    case userInfoEditor(output: UserInfoEditorOutput)
    case main(output: MainOutput)

    func createModule() -> UIViewController {
        switch self {
        case .settings(let output): 
            return SettingsCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .aboutUs(let output): 
            return AboutUsCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .loading(let output): 
            return LoadingCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .today(let output): 
            return TodayCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .general(let output): 
            return GeneralCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .locationPickerContainer(let output): 
            return LocationPickerContainerCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .userInfoEditor(let output): 
            return UserInfoEditorCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .main(let output): 
            return MainCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        }
    }
}
