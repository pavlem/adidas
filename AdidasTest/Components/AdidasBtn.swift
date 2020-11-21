//
//  AdidasBtn.swift
//  AdidasTest
//
//  Created by Pera Detlic on 22/11/2020.
//

import UIKit

class AdidasBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
