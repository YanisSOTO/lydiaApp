//
//  MainNavigator.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit

class MainNavigator: Navigator {
    
    ///Every destination possible in this navigator
    enum Destination {
        case contactDetail(viewModel: ContactDetailViewModelProtocol)
    }
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController        
    }
    
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .contactDetail(let viewModel):
            return ContactDetailViewController(viewModel: viewModel)
        }
    }
}
