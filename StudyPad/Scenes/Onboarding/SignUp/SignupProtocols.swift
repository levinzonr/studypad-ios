//
//  SignupProtocols.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol SignupInteractorInput {
    func perform(_ request: Signup.Request.CreateAccount)
}

// INTERACTOR -> PRESENTER (indirect)
protocol SignupInteractorOutput: class {
     func present(_ response: Signup.Response)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol SignupPresenterInput {
    func viewCreated()
    func handle(_ action: Signup.Action)
}

// PRESENTER -> VIEW
protocol SignupPresenterOutput: class {
    func showCreateButtonEnabled(_ enabled: Bool)
    func showLoading(_ show: Bool)
    func showError(_ error: Error)
}

protocol SignupCoordinatorInput: class {
    func showMain()
}
