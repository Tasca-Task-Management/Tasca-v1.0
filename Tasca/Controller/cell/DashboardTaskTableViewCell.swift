//
//  DashboardTaskTableViewCell.swift
//  Tasca
//
//  Created by danny santoso on 11/09/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class DashboardTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
