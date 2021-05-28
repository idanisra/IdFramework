//
//  FirebaseConfig.swift
//  IdFramework
//
//  Created by Idan Israel - Personal on 15/05/2021.
//

import Foundation
import FirebaseCore

/// MARK: - FirebaseConfig

public class FirebaseConfig {
    /// MARK: - Functions
    
    public static func setupFirebase() {
        let arguments = ProcessInfo.processInfo.arguments as [String]
        var plistFileName = "GoogleService-Info-"

        if let environment = arguments.first?.split(separator: " ").last {
            plistFileName += environment
            
            guard let plistPath = Bundle.main.path(forResource: plistFileName, ofType: "plist"), let options =  FirebaseOptions(contentsOfFile: plistPath) else {
                return
            }
            
            if FirebaseApp.app() == nil{
                FirebaseApp.configure(options: options)
            }
        }
    }
}

