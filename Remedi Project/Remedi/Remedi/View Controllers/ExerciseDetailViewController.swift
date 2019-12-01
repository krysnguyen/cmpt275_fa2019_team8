//
//  ExerciseDetailViewController.swift
//  Remedi
//
//  Created by Thong Bui on 2019-11-14.
//  Copyright © 2019 Krystal Nguyen. All rights reserved.
//

import UIKit
import WebKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var exerciseName: UILabel!
    
    @IBOutlet weak var exerciseDescription: UILabel!
    
    @IBOutlet weak var prescriptionDescription: UILabel!
    
    @IBOutlet weak var ExerciseWebView: WKWebView!
    
    var image = UIImage()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if name=="Arms"{
                  let url = URL(string: "https://youtu.be/Wa8Fk8TaXPk")
                  let request = URLRequest(url: url!)
                  ExerciseWebView.load(request)
              }
              else if name=="Legs"{
                  let url = URL(string: "https://youtu.be/8BcPHWGQO44")
                  let request = URLRequest(url: url!)
                  ExerciseWebView.load(request)
              }
              else if name=="Balance"{
                  let url = URL(string: "https://youtu.be/mQLzNf8VOIc")
                  let request = URLRequest(url: url!)
                  ExerciseWebView.load(request)
              }
        
        //img.image = image
        // Do any additional setup after loading the view.
    }
    @IBAction func backtabTapped(_ sender: Any) {
        let exerciseViewController = self.storyboard?.instantiateViewController(identifier: "ExerciseVC") as? ExerciseViewController
        self.view.window?.rootViewController = exerciseViewController
        self.view.window?.makeKeyAndVisible()}
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        
        if sender.isSelected{
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
}
