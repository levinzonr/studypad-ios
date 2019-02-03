//
//  ChallengesOverviewModels.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

enum ChallengesOverview {
    enum Request { }
    enum Response { }
    enum DisplayData { }

    enum Action {
        case typeSelected(type: ChallengesOverview.DisplayData.ChallengeType),
        notebookSelected(notebook: Notebook)
    }

    enum Route {
        case notebookSelection(type: ChallengesOverview.DisplayData.ChallengeType), challenge
    }
}

extension ChallengesOverview.Request {

}

extension ChallengesOverview.Response {

}

extension ChallengesOverview.DisplayData {
    
    enum ChallengeType {
        case written, memorize
    }
    
    struct ChallengeHolder {
        var type: ChallengeType? = nil
        var notebook: Notebook? = nil
    }
}
