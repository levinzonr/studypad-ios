//
//  ProfileViewCell.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    @IBOutlet weak var enrtyLabel: UILabel!
    @IBOutlet weak var entrySubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
    }


    
    func configure(with title: String, and subtitle: String? = nil) {
        enrtyLabel.text = title
        if let subtitle = subtitle {
            entrySubtitleLabel.text = subtitle
            entrySubtitleLabel.isHidden = false
        } else {
            entrySubtitleLabel.isHidden = true
        }
    }
    
}
