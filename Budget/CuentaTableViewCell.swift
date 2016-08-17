//
//  CuentaTableViewCell.swift
//  Budget
//
//  Created by Roberto Carlos Callisaya Mamani on 8/17/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit

class CuentaTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
