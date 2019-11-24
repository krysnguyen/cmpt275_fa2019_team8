//
//  ExerciseTableViewCell.swift
//  Remedi
//
//  Created by Thong Bui on 2019-11-12.
//  Copyright © 2019 Krystal Nguyen. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var rectangleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
