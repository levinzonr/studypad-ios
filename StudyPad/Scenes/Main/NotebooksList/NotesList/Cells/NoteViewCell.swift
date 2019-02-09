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


    @IBOutlet weak var noteContentLabel: UILabel!
    @IBOutlet weak var noteTitleLabel: UILabel!
    func configure(_ note: Note)  {
    
        noteTitleLabel.text = note.title
        noteContentLabel.text = note.content
        
        if (note.title.isEmpty) {
            noteTitleLabel.text = "<No Title>"
        }
        
        if note.content.isEmpty {
            noteContentLabel.text = "<No Content>"
        }
        
        
        
    }
    
}
