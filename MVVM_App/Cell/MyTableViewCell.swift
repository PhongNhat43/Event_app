//
//  MyTableViewCell.swift
//  MVVM_App
//
//  Created by devsenior on 10/04/2023.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

