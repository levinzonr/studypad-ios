//
//  ChallengesOverviewCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

class ChallengesOverviewCoordinator: Coordinator {
    var dependencies: AllDependencies
    
    // MARK: - Properties
    let navigationController: UINavigationController
    // NOTE: This array is used to retain child coordinators. Don't forget to
    // remove them when the coordinator is done.
    var children: [Coordinator] = []
//    weak var delegate: ChallengesOverviewCoordinatorDelegate?
    
    var challengeHolder = ChallengesOverview.DisplayData.ChallengeHolder()

    // MARK: - Init
    init(navigationController: UINavigationController, _ deps : AllDependencies = DependencyManager.shared) {
        self.navigationController = navigationController
        self.dependencies = deps
    }

    func start() {
        let interactor = ChallengesOverviewInteractor()
        let presenter = ChallengesOverviewPresenter(interactor: interactor, coordinator: self)
        let vc = ChallengesOverviewViewController.instantiate(with: presenter)
        vc.title = "Challenges"
        interactor.output = presenter
        presenter.output = vc
        
        navigationController.setViewControllers([vc], animated: false)
    }
}
// MARK: - Navigation Callbacks
// PRESENTER -> COORDINATOR
extension ChallengesOverviewCoordinator: ChallengesOverviewCoordinatorInput {
    
    func navigate(to route: ChallengesOverview.Route) {
        switch route {
        case .notebookSelection(let type):
            
            challengeHolder.type = type
            
            let interactor = NotebookSelectionInteractor(repository: dependencies.repository)
            let presenter = NotebookSelectionPresenter(interactor: interactor, coordinator: self)
            let vc = NotebookSelectionViewController.instantiate(with: presenter)
            interactor.output = presenter
            presenter.output = vc
            navigationController.pushViewController(vc, animated: true)
    
            
        case .challenge:
            print("sa")
        }
    }
}

extension ChallengesOverviewCoordinator : NotebookSelectionCoordinatorInput {
    func onNotebookSelected(_ notebook: Notebook) {
        challengeHolder.notebook = notebook
        
        let interactor = MemoInteractor(repository: dependencies.repository)
        let presenter = MemoPresenter(interactor: interactor , coordinator: self, notebook: notebook)
        let vc = MemoViewController.instantiate(with: presenter)
        presenter.output = vc
        interactor.output = presenter
        navigationController.present(vc, animated: true)
    }
    
    
}

extension ChallengesOverviewCoordinator : MemoCoordinatorInput {
    func onChallengeCompleted() {
        navigationController.dismiss(animated: true, completion: nil)
        navigationController.popToRootViewController(animated: true)
    }
    
    
}
