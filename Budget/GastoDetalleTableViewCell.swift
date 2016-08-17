//
//  GastoDetalleTableViewCell.swift
//  Budget
//
//  Created by Roberto Carlos Callisaya Mamani on 8/17/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit

class GastoDetalleTableViewCell: UITableViewCell {

    @IBOutlet weak var txtNombre: UILabel!
    @IBOutlet weak var txtTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
