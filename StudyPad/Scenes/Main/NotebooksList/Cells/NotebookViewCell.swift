//
//  NotebookViewCell.swift
//  StudyPad
//
//  Created by Roman Levinzon on 02/02/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import UIKit
import Reusable
import MaterialComponents

protocol NotebookViewCellDelegate : class  {
    func onMoreButtonClicked(_ position : Int)
    func onNotebookSelected(at position: Int)
}

class NotebookViewCell: UICollectionViewCell, Reusable {
    
    
    @IBOutlet weak var notesCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardView: MDCCard!
    
    @IBOutlet weak var gradientView: GradientView!
    weak var delegate: NotebookViewCellDelegate? = nil
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.cornerRadius = 16
    }
    
    @IBAction func onOptionsButtonPressed(_ sender: Any) {
        delegate?.onMoreButtonClicked(tag)
    }
    
    @IBAction func onCardPressed(_ sender: Any) {
        delegate?.onNotebookSelected(at: tag)
    }
    
    
    func configure(using notebook: Notebook) {
     
       nameLabel.text =  notebook.name
        notesCountLabel.text = "Count: \(notebook.notesCount)"
        
        let colors = notebook.color.toColorArray()
        gradientView.colors = colors
     
        
        
    }

}
