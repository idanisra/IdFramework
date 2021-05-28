//
//  MPCProtocol.swift
//
//  Created by Idan Israel on 10/11/2020.
//

import Foundation
import MultipeerConnectivity

/// MARK: - MPCProtocol

public protocol MPCProtocol {
    /// MARK: - Functions
    
    func updatefoundedPeer()
    func invitationWasReceived(fromPeer: String)
    func connectedWithPeer(peerID: MCPeerID)
    func connectingWithPeer(peerID: MCPeerID)
}
