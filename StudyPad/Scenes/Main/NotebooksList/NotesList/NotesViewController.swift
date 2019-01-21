//
//  NotesViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit


final class NotesViewController : UIViewController {
    
    weak var presenter: NotesPresenterImpl?
    
    
    
    static func instantiate(with presenter: NotesPresenterImpl) -> NotesViewController {
        let name = "\(NotesViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! NotesViewController
        vc.presenter = presenter
        return vc
    }
}
