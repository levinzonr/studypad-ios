//
//  ChallengesOverviewPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class ChallengesOverviewPresenter {
    // MARK: - Properties
    let interactor: ChallengesOverviewInteractorInput
    weak var coordinator: ChallengesOverviewCoordinatorInput?
    weak var output: ChallengesOverviewPresenterOutput?

    // MARK: - Init
    init(interactor: ChallengesOverviewInteractorInput, coordinator: ChallengesOverviewCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension ChallengesOverviewPresenter: ChallengesOverviewPresenterInput {
    func viewCreated() {

    }

    func handle(_ action: ChallengesOverview.Action) {
        switch action {
        case .typeSelected(let type):
            coordinator?.navigate(to: .notebookSelection(type: type))
        default:
            print("another")
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ChallengesOverviewPresenter: ChallengesOverviewInteractorOutput {

}
