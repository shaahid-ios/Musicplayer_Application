//
//  MusicCell.swift
//  MyMusic
//
//  Created by Admin on 30/12/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import UIKit
import SPAlert

class MusicCell: UITableViewCell {

    @IBOutlet weak var favbtn: UIButton!
    
    @IBOutlet var ShareBtnClicked: UIButton!
    @IBOutlet var ImgView: UIImageView!
    
    @IBOutlet var MuText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ImgView.layer.cornerRadius = 10.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favbuttontapped(_ sender: UIButton) {
        
        SPAlert.present(title: "Added to Favourites", preset: .heart)
        
        
    }
}
