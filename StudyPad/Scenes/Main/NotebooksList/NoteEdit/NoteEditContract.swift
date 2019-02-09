//
//  NoteEditContract.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

protocol NoteEditView: BaseView {
    
    func showSaveButtonEnabled(_ enabled: Bool)
    func showEditMode(_ note: Note)
    func showNoteUpdated()
    func showNoteCreated()
    func showError(_ error: Error)

}
