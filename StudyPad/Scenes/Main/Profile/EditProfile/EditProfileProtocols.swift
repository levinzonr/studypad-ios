//
//  EditProfileProtocols.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol EditProfileInteractorInput {
    func perform(_ request: EditProfile.Request.UpdateProfile)
}

// INTERACTOR -> PRESENTER (indirect)
protocol EditProfileInteractorOutput: class {
    func present(_ response: User)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol EditProfilePresenterInput {
    func viewCreated()
    func handle(_ action: EditProfile.Action)
}

// PRESENTER -> VIEW
protocol EditProfilePresenterOutput: class {
    func display(_ displayModel: User)
    func displayUpdateButtonEnabled(_ enabled: Bool)
}
