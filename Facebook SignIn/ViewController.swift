//
//  ViewController.swift
//  Facebook SignIn
//
//  Created by Mac on 23/06/23.
//

import UIKit
import FBSDKLoginKit
class ViewController: UIViewController {
    @IBOutlet weak var fbButton: FBLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
            fbLogin()
     }
    func fbLogin(){
        if let token = AccessToken.current,!token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start { connection, result, error in
                print("\(result)")
            }
        }
         else{
             fbButton.center = view.center
            fbButton.permissions = ["public_profile", "email"]
             fbButton.delegate = self
        }
       }
    }
extension ViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email,name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result)")
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
    
}
