//
//  NotebooksPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import RxSwift

final class NotebooksViewModel {
    
    var repo: Repository
    let notebooksObservable: Single<[Notebook]>
    
    init(repo: Repository) {
        self.repo = repo
        notebooksObservable = repo.getNotebooks()
    }


    
}
