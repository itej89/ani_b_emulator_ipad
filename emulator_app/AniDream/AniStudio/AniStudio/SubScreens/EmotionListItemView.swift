//
//  EmotionListItemView.swift
//  AniStudio
//
//  Created by Tej Kiran on 18/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import UIKit

class EmotionListItemView: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var JoyColor: UIView!
    @IBOutlet weak var SurpriseColor: UIView!
    @IBOutlet weak var SadColor: UIView!
    @IBOutlet weak var FearColor: UIView!
    @IBOutlet weak var AngerColor: UIView!
    @IBOutlet weak var DisgustColor: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
