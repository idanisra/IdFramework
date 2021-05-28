//
//  DataFromPeer.swift
//
//  Created by Idan Israel on 10/11/2020.
//

import Foundation
import MultipeerConnectivity

/// MARK: - DataFromPeer

public class DataFromPeer: NSObject {
    /// MARK: - Variables
    
    var data : Data?
    var fromPeer : MCPeerID
    
    public init(data: Data, fromPeer: MCPeerID) {
        self.data = data
        self.fromPeer = fromPeer
    }
}
