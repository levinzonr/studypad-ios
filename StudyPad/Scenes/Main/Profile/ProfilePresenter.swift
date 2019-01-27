//
//  Presenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation


class ProfilePresenter : BasePresenter {
    typealias View = ProfileView
    
    weak var coordinator: AppFlowDelegate?
    
    var view: ProfileView?
    let userManager: UserManager
    init(_ userManager : UserManager, coordinator: AppFlowDelegate) {
        self.userManager = userManager
        self.coordinator = coordinator
    }
    
    func attachView(view: ProfileView) {
        self.view = view
        if let user = userManager.userInfo {
            runAction { view in
                view.showProfileInfo(user)
            }
        }
    }
    
    func dettachView() {
        self.view = nil
    }
    
    
    func logout() {
        userManager.clear()
        coordinator?.showLogin()
    }
    
}
