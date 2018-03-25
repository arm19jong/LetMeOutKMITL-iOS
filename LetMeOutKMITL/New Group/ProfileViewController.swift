//
//  ProfileViewController.swift
//  LetMeOutKMITL
//
//  Created by suchaj jongprasit on 3/18/2561 BE.
//  Copyright © 2561 km. All rights reserved.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var mobilephone1: UITextField!
    @IBOutlet weak var mobilephone2: UITextField!
    @IBOutlet weak var officephone: UITextField!
    @IBOutlet weak var save: UIButton!
    let KEY_USER = "Users"
    var user:User = User()
    var uid:String = ""
    var mRootRef:DatabaseReference
    var databaseUser:DatabaseReference
    
    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        
        mRootRef = Database.database().reference()
        databaseUser = self.mRootRef.child(self.KEY_USER)
        super.init(coder: aDecoder)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uid = UserSP.sharedInstance.getUid(userDefaults: UserDefaults.standard)
        print(uid)
        getUser(uid: uid)
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        addObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeObservers()
    }
    @objc func didTapView(gesture: UITapGestureRecognizer){view.endEditing(true)}
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification:notification)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            self.keyboardWillHide(notification:notification)
        }
        
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification:Notification){
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
                return
        }
        let contentInset = UIEdgeInsets(top:0, left:0, bottom:view.convert(frame, from:view.window).height, right:0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:Notification){
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickSave(_ sender: Any) {
        user.email =  email.text!
        user.firstname = firstname.text!
        user.lastname = lastname.text!
        user.mobilephone1 = mobilephone1.text!
        user.mobilephone2 = mobilephone2.text!
        user.officephone = officephone.text!
    }
    
    func addOrEditUser(uid:String, user: User){
        databaseUser.child(uid).setValue(user)
    }
    func getUser(uid:String){
        databaseUser.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let user = User()
//            let value = snapshot.value as? [String: AnyObject]
            let value = snapshot.value as? NSDictionary
//            let key = snapshot.key
//            print ("value: \(value)")
            user.email = value?["email"] as? String ?? ""
            user.firstname = value?["firstname"] as? String ?? ""
            user.lastname = value?["lastname"] as? String ?? ""
            user.mobilephone1 = value?["mobilephone1"] as? String ?? ""
            user.mobilephone2 = value?["mobilephone2"] as? String ?? ""
            user.officephone = value?["officephone"] as? String ?? ""
            print(user)
            self.email.text = user.email
            self.firstname.text = user.firstname
            self.lastname.text = user.lastname
            self.mobilephone1.text = user.mobilephone1
            self.mobilephone2.text = user.mobilephone2
            self.officephone.text = user.officephone


        }
    }
}
