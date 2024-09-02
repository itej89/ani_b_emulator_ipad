//
//  DialogListItemView.swift
//  AniStudio
//
//  Created by Tej Kiran on 29/05/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import UIKit

class DialogListItemView: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var btnUtility: UIButton!
    
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
