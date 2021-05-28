//
//  MusicPlayer.swift
//
//  Created by Idan Israel on 12/11/2020.
//

import Foundation
import AVFoundation

/// MARK: - MusicPlayer
public class MusicPlayer {
    /// MARK: - Public Static Variables
    public static let sharedHelper = MusicPlayer()
    
    /// MARK: - Variables
    var backgroundMusicPlayer: AVAudioPlayer?
    var clicksPlayer: AVAudioPlayer?
    
    //MARK: - Public Functions
    public func playBackgroundMusic(fileName: String, fileExtension: String) {
        if let bundlePath = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            let aSound = NSURL(fileURLWithPath: bundlePath)
            do {
                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
                self.backgroundMusicPlayer!.numberOfLoops = -1
                self.backgroundMusicPlayer!.prepareToPlay()
                self.backgroundMusicPlayer!.play()
            } catch {
                print("Cannot play the file")
            }
        }
    }
    
    public func playSingleClick(fileName: String, fileExtension: String) {
        if let bundlePath = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            let aSound = NSURL(fileURLWithPath: bundlePath)
            do {
                self.clicksPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
                self.clicksPlayer!.numberOfLoops = 1
                self.clicksPlayer!.prepareToPlay()
                self.clicksPlayer!.play()
            } catch {
                print("Cannot play the file")
            }
        }
    }
}
