//
//  FirebaseAuth.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 28/05/2021.
//

import FirebaseAuth
import Foundation

/// MARK: - FirebaseAuth

public class FirebaseAuth {
    /// MARK: - Variables
    
    public static var userId: String = ""
    
    /// MARK: - Functions
    
    public static func login(email: String?, password: String?, completion: @escaping (_ _success:Bool) -> Void) {
        if Auth.auth().currentUser != nil {
            logout()
        }
        
        if let email = email, let password = password {
            Auth.auth().signIn(withEmail: email, password: password) {
                (user, error) in
                if let _ = error { completion(false) }
                else {
                    self.userId = (user?.user.uid)!
                    completion(true)
                }
            }
        }
    }
    
    public static func logout() {
        try! Auth.auth().signOut()
    }
    
    public static func registerUser(email: String, password: String, completion: @escaping (_ _success:Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let _ = error {
                completion(false)
            }
            else {
                completion(true)
            }
        }
    }
}
