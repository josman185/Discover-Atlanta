//
//  CustomCell-Favorites.swift
//  Discover-Atlanta
//
//  Created by jos on 11/1/16.
//  Copyright © 2016 myOrganization. All rights reserved.
//

import UIKit

class CustomCell_Favorites: UITableViewCell {
    
    
    @IBOutlet weak var imageLbl: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
