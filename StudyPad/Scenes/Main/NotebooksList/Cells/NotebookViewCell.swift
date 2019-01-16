//
//  NotebookViewCell.swift
//  StudyPad
//
//  Created by Roman Levinzon on 16/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
class NotebookViewCell: MDCCardCollectionCell {

    @IBOutlet weak var notebookGradientColorView: UIView!
    @IBOutlet weak var notebookNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCardView() {

        cornerRadius = 8
        
        setShadowElevation(ShadowElevation(rawValue: 16), for: .highlighted)
        setShadowColor(UIColor.black, for: .normal)
        setShadowElevation(<#T##shadowElevation: ShadowElevation##ShadowElevation#>, for: <#T##MDCCardCellState#>)
    }

}
