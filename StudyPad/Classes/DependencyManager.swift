//
//  DependencyManager.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

protocol DepsProvider {
    var repository: Repository { get }
    var userManager: UserManager { get }
}


typealias AllDependencies = DepsProvider

final class DependencyManager : AllDependencies {
    
    static let shared = DependencyManager()

    
    let repository : Repository = MockRepository()
    let userManager: UserManager = UserManager()
    
    private init() {}
    
    
}
