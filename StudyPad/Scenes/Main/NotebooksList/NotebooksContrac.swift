//
//  NotebooksView.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
protocol NotebooksContrac : BaseView {
    
    func showNotebooks(notebooks: [Notebook])

    
}

protocol NotebookPresenter: BasePresenter {
    
    func loadNotebooks()
    func createNotebook(name: String)
    func deleteNotebook(notebook: Notebook)
}


