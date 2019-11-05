//
//  ProfileViewController.swift
//  Remedi
//Team 8
//Programmers: Huy Thong, Krystal Nguyen
//UI designers: Payam Partow, David Song

import UIKit
import FirebaseFirestore
import FirebaseAuth
//Class to control the main storyboard, it will connect with Firebase for retrieving data
class ProfileViewController: UIViewController {
    var firestore: Firestore!
    var userID = Auth.auth().currentUser!.uid
    var userEmail = Auth.auth().currentUser!.email!
    var firstName = ""
    var lastName = ""
    var physID = ""
    var physFirstName = ""
    var physLastName = ""
    var physEmail = ""
    
    //These varibales using to connect the Profie storyboard with Controller
    @IBAction func logOutButton(_ sender: Any) {
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var patientnameLabel: UILabel!
    @IBOutlet weak var patientMednumLabel: UILabel!
    @IBOutlet weak var patientPhoneLabel: UILabel!
    @IBOutlet weak var patientEmailLabel: UILabel!
    @IBOutlet weak var patientHomeAddressLabel: UILabel!
    @IBOutlet weak var physNameLabel: UILabel!
    @IBOutlet weak var physPhoneLabel: UILabel!
    @IBOutlet weak var physEmailLabel: UILabel!
    @IBOutlet weak var physHomeAddLabel: UILabel!
    
    //Read data from Firestore in order to show profile for patients
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        Auth.auth().addStateDidChangeListener { auth, user in
//          guard let user = user else { return }
//        }
        let db = Firestore.firestore()
        let collectionRef = db.collection("users")
        collectionRef.document(userEmail).getDocument(completion: {(snapshot, error) in
            if let d = snapshot?.data() {
                self.firstName = d["firstname"] as! String
                self.lastName = d["lastname"] as! String
                self.patientMednumLabel.text = d["healthNumber"] as! String
                self.patientPhoneLabel.text = d["phoneNumber"] as! String
                self.patientEmailLabel.text = self.userEmail
                self.patientHomeAddressLabel.text = d["homeAddress"] as! String
                self.physID = d["doctorID"] as! String
            }
            self.patientName()
            self.physInfor()
        })
    }
    
    func patientName() {
        patientnameLabel.text = firstName +  " " + lastName
    }
    //Display information of the physicians
    func physInfor(){
        let db = Firestore.firestore()
        let collectionRef = db.collection("doctor")
        collectionRef.document(physID).getDocument(completion: {(snapshot, error) in
            if let d = snapshot?.data() {
                self.physFirstName = d["firstName"] as! String
                self.physLastName = d["lastName"] as! String
                self.physEmailLabel.text = d["physEmail"] as! String
                self.physPhoneLabel.text = d["physPhone"] as! String
                self.physHomeAddLabel.text = d["physHomeAdd"] as! String
            }
            self.physName()
        })
    }
    
    func physName() {
        physNameLabel.text = physFirstName +  " " + physLastName
    }
    //Normal mode
//    self.lbl.hidden = NO;
//    self.textfield.enabled = NO;
//    self.textfield.hidden = YES;
    //Edit mode
//    self.lbl.hidden = YES;
//    self.textfield.enabled = YES;
//    self.textfield.hidden = NO;
    func editButton(){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
