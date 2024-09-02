//
//  SoundPlayer.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 30/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

import MediaPlayer

public class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    
    var soundPlayerDelegate:SoundPlayerDelegates!
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully
        flag: Bool) {
        if(soundPlayerDelegate != nil)
        {
            soundPlayerDelegate.PlayingSoudFinished()
        }
    
    }
    var audioPlayer:AVAudioPlayer!
     var sldrUpdateTimer:Timer!
    
    func IsPlaying()->Bool
    {
        if(audioPlayer != nil && audioPlayer.isPlaying)
        {
            return true
        }
        
        return false
    }
    
    func PlaySound(fileName:String, StartSec:Int, EndSec:Int, Volume:Float = 1, FadeDuration:Float = 0)  {
        if(FileManager.default.fileExists(atPath: fileName))
        {
        if(soundPlayerDelegate != nil && soundPlayerDelegate.CanPlaySound())
        {
       
            let alertSound         = NSURL.fileURL(withPath: fileName)
            print(alertSound)
            
            // Removed deprecated use of AVAudioSessionDelegate protocol
            
            do
            {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default,  options:[AVAudioSession.CategoryOptions.defaultToSpeaker, .allowBluetoothA2DP])
                try   AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                try    audioPlayer = AVAudioPlayer(contentsOf: alertSound as URL)
                audioPlayer.delegate = self
            }
            catch
            {
                print("error in PlaySound")
                soundPlayerDelegate.ReleaseAnyLocksOnPlayError()
            }
            
            audioPlayer.setVolume(Volume, fadeDuration: TimeInterval(FadeDuration))
            audioPlayer.prepareToPlay()
            audioPlayer.currentTime = TimeInterval(round(Double(StartSec)/1000.0))
            audioPlayer.play()
             sldrUpdateTimer =  Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        }
        }
       
    }
    
    
    
    func PauseSound()
    {
        if(audioPlayer != nil)
        {
            audioPlayer.stop()
            if(sldrUpdateTimer != nil)
            {
            sldrUpdateTimer.invalidate()
            }
        }
    }
    
    @objc func updateTime(_ timer: Timer) {
        
        if(soundPlayerDelegate != nil && audioPlayer.isPlaying)
        {
            soundPlayerDelegate.PlayingSoudProgress(progress: Double(audioPlayer.currentTime))
        }
        else
        {
            sldrUpdateTimer.invalidate()
        }
        
    }
    
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
