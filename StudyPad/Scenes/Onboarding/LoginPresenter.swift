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
    
    var email: String {
        set {
            loginRequest.email = newValue
            print("set email")
            updateLoginButtonState()
        }
        get {
            return loginRequest.email
        }
    }
    
    var password: String {
        set {
            loginRequest.password = newValue
            updateLoginButtonState()
        }
        get {
            return loginRequest.password
        }
    }
    
    private var loginRequest = User.LoginRequest()

    func attachView(view: LoginView) {
        self.view = view
        view.showLoginButtonEnabled(false)
    }
    
    func dettachView() {
        self.view = nil
    }
    
    
    
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
    
    
    
    private func updateLoginButtonState() {
        print("Update")
        let validPassword = !password.isEmpty
        let validEmail = !email.isEmpty
        print("Update")

        self.runAction { (view : LoginView) in
            view.showLoginButtonEnabled(validEmail && validPassword)
        }
    }
    
}
