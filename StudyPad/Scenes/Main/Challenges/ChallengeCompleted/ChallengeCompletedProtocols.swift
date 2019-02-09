//
//  ChallengeCompletedProtocols.swift
//  StudyPad
//
//  Created by Roman Levinzon on 09/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit


protocol ChallengeCompletedCoordinatorInput {
    func finishChallenge()
    func retryChallenge()
}
