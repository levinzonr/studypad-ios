//
//  NotebooksViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

final class NotebooksViewController : UIViewController {
    
    var presenter: NotebooksPresenter!
    

    
    override func loadView() {
        super.loadView()
        print("Load View")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Notebooks view did load")
    }
    
    static func instantiate(with presenter: NotebooksPresenter) -> NotebooksViewController {
        let name = "\(NotebooksViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! NotebooksViewController
        vc.presenter = presenter
        print("Initsnaa")
        return vc
    }
    
}
