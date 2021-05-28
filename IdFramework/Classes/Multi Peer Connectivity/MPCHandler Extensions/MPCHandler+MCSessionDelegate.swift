//
//  MPCHandler+MCSessionDelegate.swift
//
//  Created by Idan Israel on 10/11/2020.
//

import Foundation
import MultipeerConnectivity

/// MARK: - MPCHandler Extension

extension MPCHandler: MCSessionDelegate {
    /// MARK: - Public Functions

    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            delegate?.connectedWithPeer(peerID: peerID)
        case .connecting:
            delegate?.connectingWithPeer(peerID: peerID)
        default:
            return
        }
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let datas = DataFromPeer(data: data, fromPeer: peerID)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MPCNotifications.ReceivedDataNotification.rawValue), object: datas)
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}
