//
//  MPCHandler+MCNearbyServiceBrowserDelegate.swift
//
//  Created by Idan Israel on 10/11/2020.
//

import Foundation
import MultipeerConnectivity

/// MARK: - MPCHandler Extension

extension MPCHandler: MCNearbyServiceBrowserDelegate {
    /// MARK: - Public Functions

    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        self.foundPeers.append(peerID)
        delegate?.updatefoundedPeer()
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        if let index = foundPeers.firstIndex(of: peerID) {
            foundPeers.remove(at: index)
        }
        delegate?.updatefoundedPeer()
    }
}
