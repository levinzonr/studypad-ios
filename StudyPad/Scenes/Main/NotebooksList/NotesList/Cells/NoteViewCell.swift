//
//  NoteViewCell.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import UIKit
import Reusable

class NoteViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var noteTitleLabel: UILabel!

    func configure(_ note: Note)  {
        noteTitleLabel.text = note.title
        print("configure")
    }
    
}
