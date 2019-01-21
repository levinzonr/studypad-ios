//
//  Presenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

protocol BasePresenter : class {
    associatedtype View
    
    var view: View? { get set }

    
    func attachView(view: View)
    func dettachView()
    
}

extension BasePresenter  {
    
    func runAction(_ block: (View) -> Void) {
        if let view  = self.view {
            block(view)
        }
    }
}

