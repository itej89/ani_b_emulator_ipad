//
//  SpeexT.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 30/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation
import Speech



public class SpeexT {
    
    
    var speexTDelegate:SpeexTDelegates!
    
    var audioEngine:AVAudioEngine? = AVAudioEngine()
    var speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    var request: SFSpeechAudioBufferRecognitionRequest?
    var recognizationTask: SFSpeechRecognitionTask?
    
    
    var timer:Timer?
    public var isRecRunning: Bool = false
    //Becomes True on Start listening and false when SentanceFinalized
    var SentenceRecognitionStarted: Bool = true
    
    @objc func update(){
        pauseRec()
        speexTDelegate.SpeexTListeningIDLETimeout()
    }
    
    
    // call this function to start recognization
    public func startRec(){
        
        
        
        self.recordAndRecognizeSpeech()
        
        do{
            SentenceRecognitionStarted = true
            isRecRunning = true
            try audioEngine?.start()
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.update), userInfo: nil, repeats: false);
            
        } catch {
            return print(error)
        }
    }
    
    // call this function to pause recognization
    public func pauseRec(){
        
        
        if isRecRunning == false {
            return
        }
        
        isRecRunning = false
        timer?.invalidate()
        if audioEngine != nil {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
            request?.endAudio()
            recognizationTask?.cancel()
            request = nil
            recognizationTask = nil
            audioEngine = nil
            speechRecognizer = nil
            SentenceRecognitionStarted = false
        }
       
        speexTDelegate.SpeexTStopped()
    }
    
    func SentenceFinalizedByUppedLayer()
    {
        if(SentenceRecognitionStarted == true)
        {
           timer?.invalidate()
        }
    }
    
    
    func recordAndRecognizeSpeech(){
        audioEngine = AVAudioEngine()
        speechRecognizer = SFSpeechRecognizer()
        request = SFSpeechAudioBufferRecognitionRequest()
        guard let node = audioEngine?.inputNode else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){ buffer, _ in
            self.request?.append(buffer)
            
        }
        
        audioEngine?.prepare()
        
        
        guard let myRecognizer = SFSpeechRecognizer() else{
            // rec is not supported
            return;
        }
        if !myRecognizer.isAvailable{
            // rec is not available now!
            return;
        }
        
        recognizationTask = speechRecognizer?.recognitionTask(with: request!, resultHandler: { (result, error) in
            if let result = result {
                
                let text = result.bestTranscription.formattedString
                
                self.speexTDelegate.SendSpeexT(data: text)
                
            }else if  (error != nil) || (result?.isFinal)!{
                self.pauseRec()
            }
        })
        

    }
    
}

