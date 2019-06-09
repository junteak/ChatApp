//
//  SignInViewController.swift
//  ChatApp
//
//  Created by 潤田中 on 2019/06/09.
//  Copyright © 2019 BCC. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //２つのデリゲートのプロトコルを追加
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        
    }
    
    
    //チャット画面への遷移メソッド "toChatRoom"はセグエのidentifier
    func transitionToChatRoom() {
        performSegue(withIdentifier: "toChatRoom", sender: self)//"toChatRoom"というIDで識別
    }
    
    
    
    //Googleサインインに関するデリゲートメソッド
    //signIn:didSignInForUser:withError: メソッドで、Google ID トークンと Google アクセス トークンを
    //GIDAuthentication オブジェクトから取得して、Firebase 認証情報と交換します。

    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
        
        if let error = error {
            print(error.localizedDescription)
            return
        
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        
        //最後に、認証情報を使用して Firebase での認証を行います
        Auth.auth().signInAndRetrieveData(with: credential) { (authDataResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("\nSignin succeeded\n")
            //transitionというチャットルームに移動する
            self.transitionToChatRoom()
        }
    
    }

    @IBAction func tappedSignOut(_ sender: Any) {
  
        //認証
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("SignOut is succeeded")
            reloadInputViews()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    /* ここまで追加 */
    
        
    }



    
    
    

