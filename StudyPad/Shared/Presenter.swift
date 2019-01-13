//
//  Presenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class Presenter<T> {
    
    var view: T!

    func attachView(view: T) {
        self.view = view
    }
    func dettachView() {
        self.view = nil
    }
    
}
