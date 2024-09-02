//
//  fmServiceInterface.swift
//  FourierMachines.Ani.Client.AI
//
//  Created by Tej Kiran on 12/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation
import Starscream
import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_Common

public class fmServiceInterface
{
    
    var ServerManagerDelegate:AIServerDelegates!
    
    
    var Server_link = "192.168.1.40:8088"
    
    func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{
        
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        if JSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                
                print("error")
                //Access error here
            }
        }
        return ""
    }
    
    
    func  ConversationQuery(Question: String) {
        
        let socket:WebSocket = createSocket("chat")
        
        socket.onConnect = {
            let query  = "{ "+" \"Type\": \"QA\", \n \"message\": \""+Question+"\"}"
            
            socket.write(string: query)
        }
        
        socket.onDisconnect = { (error: NSError?) in
            print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
            } as? ((Error?) -> Void)
        
        socket.onText = { (text: String) in
            if(self.ServerManagerDelegate != nil){
                
                if let data = text.data(using: .utf8) {
                    do {
                        let dictionary:[String: Any]! = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        
                        if(dictionary != nil && dictionary.count > 0){
                        let QAResponse = ServiceQAResponseWithEmo()
                        QAResponse.Message = dictionary?["message"] as! String
                        QAResponse.Joy = Float(dictionary?["joy"] as! String)!
                        QAResponse.Anger = Float(dictionary?["anger"] as! String)!
                        QAResponse.Surprise = Float(dictionary?["surprise"] as! String)!
                        QAResponse.Sadness = Float(dictionary?["sadness"] as! String)!
                        QAResponse.Fear = Float(dictionary?["fear"] as! String)!
                        QAResponse.Disgust = Float(dictionary?["disgust"] as! String)!
                        
                        
                        
                        
                        if(self.ServerManagerDelegate != nil){
                            let dbHAndler = DB_Local_Store()
                          let animationExpression =  dbHAndler.readExpressionByEmotion(Joy: QAResponse.Joy, SURPRISE: QAResponse.Surprise, FEAR: QAResponse.Fear, ANGER: QAResponse.Anger, SADNESS: QAResponse.Sadness, DISGUST: QAResponse.Disgust)
                            
                       
                         
                            if(animationExpression.Action_Data != nil || animationExpression.Action_Data != "")
                            {
                                self.ServerManagerDelegate.RecievedAnswerWithEmotion(response: QAResponse.Message,data: animationExpression.Action_Data)
                            }
                        }
                        
                        
                        
                    }
                    }
                        catch {
                    }
                    
                }
                
            }
            print("got some text: \(text)")
            socket.disconnect()
        }
        
        socket.onData = { (data: Data) in
            print("got some data: \(data.count)")
            socket.disconnect()
        }
        
        socket.connect()
    }
    
    
    func createSocket(_ cmd: String) -> WebSocket {
        return WebSocket(url: URL(string: "ws://"+Server_link+"/"+cmd)!, protocols: [])
    }

    
    
}
