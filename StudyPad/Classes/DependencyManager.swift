//
//  DependencyManager.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

protocol ProvidesRepository {
    var repository: Repository { get }
}

typealias AllDependencies = ProvidesRepository

final class DependencyManager : AllDependencies {
    
    static let shared = DependencyManager()
    
    
    let repository : Repository = MockRepository()
    
    private init() {}
    
    
}
