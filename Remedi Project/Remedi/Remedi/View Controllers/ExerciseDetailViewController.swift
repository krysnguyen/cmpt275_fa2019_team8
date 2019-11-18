//
//  ExerciseDetailViewController.swift
//  Remedi
//
//  Created by Thong Bui on 2019-11-14.
//  Copyright © 2019 Krystal Nguyen. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var image = UIImage()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.text = "Please do this exercise"
        img.image = image
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        
        if sender.isSelected{
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
}
