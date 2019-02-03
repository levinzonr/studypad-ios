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
    weak var coord: ProfileFlowDelegate?
    var view: ProfileView?
    let userManager: UserManager
    init(_ userManager : UserManager, coordinator: AppFlowDelegate,_  profileCoordinator: ProfileFlowDelegate) {
        self.userManager = userManager
        self.coordinator = coordinator
        self.coord = profileCoordinator
    }
    
    func attachView(view: ProfileView) {
        self.view = view
      
    }
    
    func loadProfile() {
        if let user = userManager.userInfo {
            runAction { view in
                view.showProfileInfo(user)
            }
        }
    }
    
    func dettachView() {
        self.view = nil
    }
    
    func editProfile() {
        coord?.showEditProfile()
    }
    
    
    func logout() {
        userManager.clear()
        coordinator?.showLogin()
    }
    
}
