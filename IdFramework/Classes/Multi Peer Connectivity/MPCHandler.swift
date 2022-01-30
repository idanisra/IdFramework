//
//  MPCHandler.swift
//
//  Created by Idan Israel on 09/11/2020.
//
//  Very Important: Add "Bonjour Services" to .plist file with two properties:
//  (Assuming the selected serviceName is set to be "newApp":
//  1. Add _newApp._tcp
//  2. Add _newApp._udp
//

import Foundation
import MultipeerConnectivity

// MARK: - MPCHandler

public class MPCHandler: NSObject {
    
    // MARK: - Variables
    
    public var peerID: MCPeerID?
    public var session: MCSession?
    public var browser: MCNearbyServiceBrowser?
    public var advertiser: MCNearbyServiceAdvertiser?
    public var foundPeers: [MCPeerID] = []
    public var delegate: MPCProtocol?
    public var invitationHandler: ((Bool, MCSession?)->Void)?
    
    // MARK: - Public Functions
    
    public func setupPeerID () {
        self.peerID = MCPeerID(displayName: UIDevice.current.name)
    }
    
    public func setupSession() {
        guard let peerID = self.peerID else { return }
        
        self.session = MCSession(peer: peerID)
        self.session?.delegate = self
    }
    
    public func setupBrowser(serviceType: String) {
        guard let peerID = self.peerID else { return }
        
        self.browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        self.browser?.delegate = self
    }
    
    public func setupAdvertiser(serviceType: String) {
        guard let peerID = self.peerID else { return }
        
        self.advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        
        self.advertiser?.delegate = self
    }
    
    public func startServices() {
        self.browser?.startBrowsingForPeers()
        self.advertiser?.startAdvertisingPeer()
    }
    
    public func stopServices() {
        self.browser?.stopBrowsingForPeers()
        self.advertiser?.stopAdvertisingPeer()
    }
}
