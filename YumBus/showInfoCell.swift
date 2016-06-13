//
//  showInfoCell.swift
//  YumBus
//
//  Created by Seungheon Yum on 5/30/16.
//  Copyright © 2016 syumdev. All rights reserved.
//

import UIKit

class showInfoCell: UITableViewCell {

    @IBOutlet weak var _lblBusNumber: UILabel!
    @IBOutlet weak var _lblBusStop: UILabel!
    @IBOutlet weak var _lblBusDirection: UILabel!
    @IBOutlet weak var _lblBusTimeLeft: UILabel!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
