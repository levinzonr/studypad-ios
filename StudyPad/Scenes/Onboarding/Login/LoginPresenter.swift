//
//  LoginPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore

class LoginPresenter : BasePresenter {
    typealias View = LoginView
    var view: LoginView?
    
    var email: String {
        set {
            loginRequest.email = newValue
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
        view.showLoading(false)
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
        
        self.runAction {$0.showLoading(true)}
        
        repository.login(request: loginRequest) { (res: AppResult<User.Authorization>) in
            
            switch res {
            case .success(let auth):
                self.userManager.token = auth.access_token
                self.userManager.userInfo = auth.user
                print("user info set: \n\n\n\(auth.user)")
                self.coordiantor?.finish()
            case .failure(let error):
                self.runAction{
                    $0.showLoading(false)
                    $0.showError(error)
                }
            }
            
           
        }
    }
    
    func loginViaFacebook() {
        let manager = LoginManager()
        
        self.runAction {$0.showLoading(true)}
        
        manager.logIn(readPermissions: [.publicProfile, .email], viewController: nil) { loginResult in
            switch loginResult {
            case .success( _, _, let accessToken):
                self.repository.loginViaFacebook(token: accessToken.authenticationToken, onComplete: { response in
                    switch response {
                    case .success(let auth):
                        print("Succes: \(accessToken)")
                        self.userManager.token = auth.access_token
                        self.userManager.userInfo = auth.user
                        self.coordiantor?.finish()
                    case .failure(let error):
                        self.runAction{ view in view.showError(error) }
                    }
                   
                })
            case .cancelled:
                self.runAction{$0.showLoading(false)}
            case .failed(let error):
                self.runAction{$0.showLoading(false)}
                print("Error: \(error)")
            }
        }
    }
    
    
    func showCreateAccount() {
        coordiantor?.showSignup()
    }
    
    
    
    private func updateLoginButtonState() {
        let validPassword = !password.isEmpty
        let validEmail = !email.isEmpty

        self.runAction { (view : LoginView) in
            view.showLoginButtonEnabled(validEmail && validPassword)
        }
    }
    
    
}
