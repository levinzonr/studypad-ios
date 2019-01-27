//
//  SignupCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//Copyright © 2019 Roman Levinzon. All rights reserved.
//

import UIKit

class SignupCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var dependencies: AllDependencies = DependencyManager.shared
    let navigationController: UINavigationController
    weak var delegate: LoginFlowDelegate?
    
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        let interactor = SignupInteractor(repository: dependencies.repository)
        let presenter = SignupPresenter(interactor: interactor, coordinator: self)
        let vc = SignupViewController.instantiate(with: presenter)
        interactor.output = presenter
        presenter.output = vc

        
        navigationController.pushViewController(vc, animated: true)
        
    }
}

extension SignupCoordinator : SignupCoordinatorInput {
    func showMain() {
        delegate?.finish()
    }
    
    
    
    
}
