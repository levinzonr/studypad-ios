//
//  ProfileProtocols.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

protocol ProfileView : BaseView {
    
    func showProfileInfo(_ user: User)
    
}

protocol ProfileFlowDelegate : class {
    func showEditProfile()
}
