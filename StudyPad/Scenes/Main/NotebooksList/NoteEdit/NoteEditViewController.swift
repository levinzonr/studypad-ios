//
//  NoteEditViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit


class NoteEditViewController : UIViewController {
    
    var presenter: NoteEditPresenter!
    
    static func newInstance(with presenter: NoteEditPresenter) -> NoteEditViewController {
        let name = "\(NoteEditViewController.self)"
        let sb = UIStoryboard(name: name, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier:   name) as! NoteEditViewController
        vc.presenter = presenter
        return vc
    }
    
}

