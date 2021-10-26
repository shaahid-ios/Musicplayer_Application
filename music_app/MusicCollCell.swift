//
//  MusicCollCell.swift
//  music_app
//
//  Created by Shaahid on 06/10/21.
//

import UIKit

class MusicCollCell: UICollectionViewCell {
    
    
    @IBOutlet weak var collImage: UIImageView!
    
    @IBOutlet weak var collsonglab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        collImage.makeRounded()
        
    }
}

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 0.2
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
