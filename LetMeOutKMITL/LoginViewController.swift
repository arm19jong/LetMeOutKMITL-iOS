//
//  LoginViewController.swift
//  LetMeOutKMITL
//
//  Created by suchaj jongprasit on 3/18/2561 BE.
//  Copyright © 2561 km. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    var btnSignIn : GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view, typically from a nib.
        print("Login Activity")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
//        GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(UserSP.sharedInstance.getUid(userDefaults: UserDefaults.standard) != ""){
            changViewController()
        }
    

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        print("sign \(user.profile.email)")
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            // ...

            print (user?.uid ?? "uid = null")
            UserSP.sharedInstance.setUid(userDefaults: UserDefaults.standard, uid: (user?.uid)!)
        }
    }
    
    func changViewController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MainController") as! MainController
        
        self.present(resultViewController, animated:true, completion:nil)
    }
    
}
