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

    
    @IBOutlet weak var emailField: FancyTextField!
    @IBOutlet weak var pwdField: FancyTextField!
    
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
    
    
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("RAEL: Email user authenticated with FIREBASE")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            print("RAEL: Unable to authenticate with FIREBASE with email")
                            
                        } else {
                            print("RAEL: Successfully authenticated with FIREBASE")
                        }
                    })
                    
                }
            })
        }
        
    }
    
    
    
}
