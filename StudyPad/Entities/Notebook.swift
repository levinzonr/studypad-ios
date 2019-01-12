//
//  Notebook.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

struct Notebook : Codable {
    var id: Int
    var name: String
    var notesCount : Int
    var gradientColor: GradientColor
}


struct GradientColor : Codable {
    var firstColor: String
    var secondColor: String
}
