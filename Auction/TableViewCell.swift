//
//  TableViewCell.swift
//  Auction
//
//  Created by mac3 on 11/17/17.
//  Copyright © 2017 PACE. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblBp: UILabel!
    @IBOutlet weak var lblCp: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
