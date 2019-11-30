//
//  NextScheduleViewController.swift
//  Remedi
//
//  Created by Huy thong Bui on 11/29/19.
//  Copyright © 2019 Krystal Nguyen. All rights reserved.
//

import UIKit

class NextScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var name = ["Arms","Legs","Balance"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (name.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NextScheduleTableViewCell
        cell.myImage.image = UIImage(named: name[indexPath.row])
        cell.myLabel.text = name[indexPath.row]
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    @IBOutlet weak var DateLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        DateLabel.text = dateString
    }
}


