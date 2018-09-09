//
//  RepoTableViewCell.swift
//  Github-Client
//
//  Created by Kunal Gandhi on 07.09.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoSize: UILabel!
    @IBOutlet weak var lastUpdatedDate: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    
    func configureSelf(data: Repository) {
        repoName.text = data.name.capitalized
        repoSize.text = "\(data.size) KB"
        createdDate.text = data.createdDate
        lastUpdatedDate.text = data.updatedDate
        guard let language = data.language else { repoLanguage.text = "None"; return }
        repoLanguage.text = language
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
