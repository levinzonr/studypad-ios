//
//  ChallengeCompletedPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 09/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class ChallengeCompletedPresenter {
    // MARK: - Properties
    let interactor: ChallengeCompletedInteractorInput
    weak var output: ChallengeCompletedPresenterOutput?
    
    // Your custom coordinator
    // weak var coordinator: ChallengeCompletedCoordinatorInput?

    // MARK: - Init
    init(interactor: ChallengeCompletedInteractorInput/*,
         coordinator: ChallengeCompletedCoordinatorInput*/) {
        self.interactor = interactor
        /*self.coordinator = coordinator*/
    }
}

// MARK: - User Events -

extension ChallengeCompletedPresenter: ChallengeCompletedPresenterInput {
    func viewCreated() {

    }

    func handle(_ action: ChallengeCompleted.Action) {
        
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ChallengeCompletedPresenter: ChallengeCompletedInteractorOutput {

}
