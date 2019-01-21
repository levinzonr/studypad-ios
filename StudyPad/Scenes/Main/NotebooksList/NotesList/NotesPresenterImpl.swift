//
//  NotesPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class NotesPresenterImpl: NotesPresenter {
    typealias View = NotesView
    weak var view: NotesView?
    
    let repo: NotesRepository
    
    init(repo: NotesRepository) {
        self.repo = repo
    }
    
    func attachView(view: NotesView) {
        self.view = view
    }
    
    func dettachView() {
        self.view = nil
    }
    
}
