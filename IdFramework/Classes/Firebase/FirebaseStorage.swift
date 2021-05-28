//
//  FirebaseStorage.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 28/05/2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

/// MARK: - FirebaseStorage

public class FirebaseStorage {
    /// MARK: - Variables
    
    public static var storage: Storage?
    
    /// MARK: - Functions
    
    public static func initStorage() {
        if self.storage == nil {
            self.storage = Storage.storage()
        }
    }
    
    public static func getUrl(filePath: String , completion: @escaping (_ success: Bool, _ url: URL?) -> Void) {
        if let storage = self.storage {
            let storageRef = storage.reference(withPath: filePath)
            
            storageRef.downloadURL { url, err in
                if let error = err {
                    print("Error getting url: \(error)")
                    completion(false, nil)
                }
                else {
                    completion(true, url)
                }
            }
        }
    }
    
    public static func delete(fileToDelete: String) {
        if let storage = self.storage {
            let storageRef = storage.reference().child(fileToDelete)
            
            storageRef.delete { error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    public static func upload(fileData: Data, targetPath: String, completion: @escaping (_ _success:Bool) -> Void) {
        if let storage = self.storage {
            let storageRef = storage.reference().child(targetPath)
    
            storageRef.putData(fileData, metadata: nil) { (metaData, error) in
                if error != nil {
                    print (error as Any)
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
}
