//
//  MqttManager.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 19/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class MqttManager: NSObject, MQTTSessionDelegate
{
    var mqttSession: MQTTSession!
    var delegate : MqttInterfaceConvey?
    
    var PacketBuffer:[BufferDataPacket] = []
    var IsSendingInProgess = false
    
    override init() {
        
        super.init()
        
    }
    
    //MqttAccess
    
    public func Initialize(_delegate:MqttInterfaceConvey)
    {
        if(mqttSession != nil)
        {
            mqttSession.disconnect()
        }
        
        delegate = _delegate
    }
    
    func GetMQTTSession()->MQTTSession
    {
        let  mqttSession:MQTTSession = MQTTSession(
        host: MQTTMetaData.BROKER_IP,
        port: MQTTMetaData.BROKER_PORT,
        clientID: MQTTMetaData.CLIENT_ID, // must be unique to the client
        cleanSession: true,
        keepAlive: 15,
        useSSL: false
        )
        mqttSession.username = "ANI_HOME"
        mqttSession.password = "tejkiranani9"
        
        mqttSession.delegate = self
        
        return mqttSession
        
    }
    
 
    
    
    public func ConnectToBroker()
    {
        
        self.mqttSession = self.GetMQTTSession()
            self.mqttSession.connect { (errs) in
            if(errs == .none && self.delegate != nil)
            {
                self.PacketBuffer.removeAll()
                self.IsSendingInProgess = false
                self.delegate?.ConnectedToBroker(Status: true)
            }
            else
            {
                self.delegate?.ConnectedToBroker(Status: false)
            }
        }
    }
    
    public func DisconnectFromBroker()
    {
        PacketBuffer.removeAll()
        IsSendingInProgess = false
        mqttSession.disconnect()
    }
    
    typealias CompletionBlock = (_ error: MQTTSessionError) -> Void
    
    public func SubscribeTo(Channel:String)
    {
        let done:CompletionBlock = {(err) in
            if(err == .none && self.delegate != nil)
            {
                self.delegate?.SubscribedToChannel(Channel: Channel, Status: true)
            }
            else
            {
                self.delegate?.SubscribedToChannel(Channel: Channel, Status: false)
            }
        }
        mqttSession.subscribe(to: [Channel: MQTTQoS.exactlyOnce], completion: done)
    }
    
    public func UnSubscribeFrom(Channel:String)
    {
        mqttSession.unSubscribe(from: [Channel], completion:{(err) in
            if(err == .none && self.delegate != nil)
            {
                self.delegate?.UnsubscribedFromChannel(Channel: Channel, Status: true)
            }
            else
            {
                self.delegate?.UnsubscribedFromChannel(Channel: Channel, Status: false)
            }
        })
    }
    //End of MqttAccess
    
    
    
    func Send(FrameID:String, data : String, toChannel:String, IsWaitForAck:Bool) {
        
        
        
        let DataPacket = BufferDataPacket(_FrameID: FrameID, _data: data, _toChannel: toChannel, _IsWaitForAck: IsWaitForAck)
        PacketBuffer.append(DataPacket)
        
        PublishNextPacket()
    }
    
    var IsQueRunning = false;
    func PublishNextPacket()
    {
        if(!IsQueRunning)
        {
        DispatchQueue.main.async(execute: {
              self.IsQueRunning = true
            repeat
        {
          
            if(self.PacketBuffer.count > 0)
            {
                let NextPacket = self.PacketBuffer[0]
                if(NextPacket.IsWaitForAck)
                {
                    self.IsSendingInProgess = true
                }
                else
                {
                    self.IsSendingInProgess = false
                    self.PacketBuffer.remove(at: 0)
                }
                let mqData = NextPacket.data.data(using: .utf8)!
                
                self.mqttSession.publish(mqData, in: NextPacket.toChannel, delivering: MQTTQoS.atLeastOnce, retain: false, completion: {(err)  in
                    if(self.delegate != nil)
                    {
                        if(err == .none)
                        {
                            self.delegate?.FrameSent(Frame_ID: NextPacket.FrameID, Status: true)
                        }
                        else
                        {
                            self.delegate?.FrameSent(Frame_ID: NextPacket.FrameID, Status: false)
                        }
                    }
                })
                
            }
        }while (!self.IsSendingInProgess && self.PacketBuffer.count > 0)
            
            self.IsQueRunning = false
        })
    }
    }
    
    
    //MQTTSessionDelegate
    public func mqttDidReceive(message: MQTTMessage, from session: MQTTSession) {
        if(self.delegate != nil)
        {
            let strFrame = String(data: message.payload, encoding: .utf8)
            let rxFrameParser = RxFrameParser()
            if(strFrame != nil && strFrame != "")
            {
                let state = rxFrameParser.GetBaseFrame(Json: strFrame!)
                if(state.0 != ANIMSG.NA)
                {
                    if(IsSendingInProgess && state.1.FRAME_ID == PacketBuffer[0].FrameID)
                    {
                        IsSendingInProgess = false
                        if(PacketBuffer.count > 0)
                        {
                            PacketBuffer.remove(at: 0)
                        }
                        PublishNextPacket()
                    }
                    
                    DispatchQueue.main.async {
                       self.delegate?.FrameRecieved(FrameType:state.1.jANIMSG, Json: strFrame!)
                    }
                }
                
            }
        }
    }
    
    public func mqttDidAcknowledgePing(from session: MQTTSession) {
    }
    
    public func mqttDidDisconnect(session: MQTTSession, error: MQTTSessionError) {
        if(self.delegate != nil)
        {
            if(error == .none)
            {
                self.delegate?.DisconnectedFromBroker(Status: true)
            }
            else
            {
                self.delegate?.DisconnectedFromBroker(Status: true)
            }
        }
    }
    //End of MQTTSessionDelegate
}
