//
//  BranchTableViewCell.swift
//  Github-Client
//
//  Created by Kunal Gandhi on 08.09.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import UIKit

class BranchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var branchName: UILabel!
    
    func configureSelf(data: String) {
        branchName.text = data
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
