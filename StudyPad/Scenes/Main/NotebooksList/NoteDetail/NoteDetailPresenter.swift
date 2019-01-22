//
//  NoteDetailPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

final class NoteDetailPresenter: BasePresenter {
    
    let note: Note
    
    init(note: Note) {
        self.note = note
    }
    
    typealias View = NoteDetailView
    var view: NoteDetailView?
    
    func attachView(view: NoteDetailView) {
        self.view = view
        self.runAction { (view: NoteDetailView) in
            view.showNote(note)
        }
    }
    
    func dettachView() {
        self.view = nil
    }
    
    
    
}
