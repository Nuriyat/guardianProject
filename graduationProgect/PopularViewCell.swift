//
//  PopularViewCell.swift
//  graduationProgect
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class PopularViewCell: UITableViewCell {

    
    @IBOutlet weak var popularImage: UIImageView!
    @IBOutlet weak var titlePopularLabel: UILabel!
    @IBOutlet weak var descriptionPopularLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
