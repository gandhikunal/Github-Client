//
//  CollaboratorTableViewCell.swift
//  Github-Client
//
//  Created by Kunal Gandhi on 08.09.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import UIKit

class CollaboratorTableViewCell: UITableViewCell {

    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var userType: UILabel!
    
    func configureSelf(name: String, type: String) {
        loginName.text = name
        userType.text = type
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
