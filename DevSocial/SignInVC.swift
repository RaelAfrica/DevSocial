//
//  ViewController.swift
//  DevSocial
//
//  Created by Rael Kenny on 5/9/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("RAEL: Unable to authenticate with facebook - \(error)")
            } else if result?.isCancelled == true {
                print("RAEL: User cancelled Facebook authentication")
            } else {
                print("RAEL: Successfully authenticated with FACEBOOK")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
            }
        }
    }

    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("RAEL: Unable to authenticate with firebase - \(error)")
            } else {
                print("RAEL: successfully authenticated with FIREBASE")
            }
        })
    }
    
    
    
    
    
    
}
