//
//  MPCHandler+MCNearbyServiceAdvertiserDelegate.swift
//
//  Created by Idan Israel on 10/11/2020.
//

import Foundation
import MultipeerConnectivity

/// MARK: - MPCHandler Extension
extension MPCHandler: MCNearbyServiceAdvertiserDelegate {
    /// MARK: - Public Functions
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        self.invitationHandler = invitationHandler
        self.delegate?.invitationWasReceived(fromPeer: peerID.displayName)
    }
}
