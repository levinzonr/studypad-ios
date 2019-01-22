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
    
    
    let loginRequest = User.LoginRequest()
    
    let repository: KeychainRepository
    let coordiantor: LoginFlowDelegate?
    let userManager: UserManager
    
    init(deps: AllDependencies, coordinator: LoginFlowDelegate) {
        self.repository = deps.repository
        self.coordiantor = coordinator
        self.userManager = deps.userManager
    }

    func login()  {
        repository.login(request: loginRequest) { (res: User.LoginResponse) in
            self.userManager.token = res.token
            self.coordiantor?.finish()
        }
    }
    
}
