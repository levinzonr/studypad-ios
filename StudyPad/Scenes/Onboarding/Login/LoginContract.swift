//
//  LoginContract.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

protocol LoginView : BaseView {
    
    
    func showLoginButtonEnabled(_ enabled: Bool)
    func showLoading(_ show: Bool)
    func showError(_ error: Error)
    
}
