//
//  LoginPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation


class LoginPresenter : BasePresenter {
    typealias View = LoginView
    var view: LoginView?
    
    func attachView(view: LoginView) {
        self.view = view
    }
    
    func dettachView() {
        self.view = nil
    }
    
    
    let userManager: UserManager
    let coordiantor: LoginFlowDelegate?
    
    init(deps: AllDependencies, coordinator: LoginFlowDelegate) {
        self.userManager = deps.userManager
        self.coordiantor = coordinator
    }

    func login()  {
        userManager.loginViaEmail(email: "mai", password: "pass") { (Bool) in
            self.coordiantor?.finish()
        }
    }
    
}
