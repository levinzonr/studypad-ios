//
//  NotebookViewCell.swift
//  StudyPad
//
//  Created by Roman Levinzon on 16/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

protocol NotebookViewCellDelegate: class {
    func onMoreButtonClicked(index: Int)
}

class NotebookViewCell: MDCCardCollectionCell {


    @IBOutlet weak var notebookGradientColorView: UIView!
    @IBOutlet weak var notebookNameLabel: UILabel!
    weak var delegate: NotebookViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onMoreButtonClicked(_ sender: Any) {
        delegate?.onMoreButtonClicked(index: tag)
    }
    func setupCardView() {

        cornerRadius = 8
        
        setShadowElevation(ShadowElevation(rawValue: 16), for: .highlighted)
        setShadowColor(UIColor.black, for: .normal)
    }

}
