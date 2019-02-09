//
//  NotebooksView.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
protocol NotebooksView : BaseView {
    
    func showNotebooks(notebooks: [Notebook])
    func showEmptyView()
    func showLoadingError()
    func showError(_ error: Error)
}

protocol NotebooksCoordinatorDelegate: class {
    
    func showNotesView(notebook: Notebook)
   
}
