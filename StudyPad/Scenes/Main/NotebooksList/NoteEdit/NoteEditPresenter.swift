//
//  NoteEditPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class NoteEditPresenter: BasePresenter {
    var view: NoteEditView?
    typealias View = NoteEditView

    let note: Note?
    
    init(note: Note? = nil) {
        self.note = note
    }
    
    func attachView(view: NoteEditView) {
        self.view = view
    }
    
    func dettachView() {
        self.view = nil
    }
    
    
    
    
}
