//
//  ChallengesOverviewProtocols.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol ChallengesOverviewCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol ChallengesOverviewCoordinatorInput: class {
    func navigate(to route: ChallengesOverview.Route)
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol ChallengesOverviewInteractorInput {
    // func perform(_ request: ChallengesOverview.Request.Work)
}

// INTERACTOR -> PRESENTER (indirect)
protocol ChallengesOverviewInteractorOutput: class {
    // func present(_ response: ChallengesOverview.Response.Work)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol ChallengesOverviewPresenterInput {
    func viewCreated()
    func handle(_ action: ChallengesOverview.Action)
}

// PRESENTER -> VIEW
protocol ChallengesOverviewPresenterOutput: class {
    // func display(_ displayModel: ChallengesOverview.DisplayData.Work)
}
