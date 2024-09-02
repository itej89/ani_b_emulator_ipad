//
//  UDPListen.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import CocoaAsyncSocket

public class UDPListen: NSObject, IValidation, GCDAsyncUdpSocketDelegate
{

    
    //GCDAsyncUdpSocketDelegate
    public func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
                        let Frame = [UInt8](data)
                            if(Frame.count > 0)
                            {
                                if(self.TimeOut != nil)
                                {
                                    self.TimeOut.invalidate()
                                }
                                if(self.UDPClientConvey != nil)
                                {
                                    let junkyHost = GCDAsyncUdpSocket.host(fromAddress: address)
                                    let hostIp = matches(for: "[0-9.]", in: junkyHost!).joined()
                                    
                                    self.UDPClientConvey.DataRecieved(recievedData: RecievedData(_RemoteEndPoint: IPEndPoint(_IPAddress: hostIp, _Port: DOIPParameters.Instance.DOIP_ENTITY_UDP_DISCOVER), _recvBuffer: Frame))
                                }
                            }
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    public func udpSocket(_ sock: GCDAsyncUdpSocket, didNotConnect error: Error?) {
    }

    public func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
    }
    //End of GCDAsyncUdpSocketDelegate
    
    
    public var ValidationErrors: ValidationRuleMessages
    
    var TimeOut:Timer!
    public static var Instance:UDPListen = UDPListen()
    public var udpClient:GCDAsyncUdpSocket!
    public var IsUDPTimedOut:Bool = false
    
    override init()
    {
       ValidationErrors = ValidationRuleMessages()
    }
    
    public var UDPClientConvey:TransportClientConvey!
    
    
    @objc func Timeout_Elapsed() {
        TimeOut.invalidate()
        IsUDPTimedOut = true
        if(UDPClientConvey != nil)
        {
            UDPClientConvey.Timeout(code: DIAGNOSTIC_STATUS.CODE.UDP_TIMEOUT.rawValue)
        }
    }
    
    func StartListeningTimeOut() {
        IsUDPTimedOut = false
        TimeOut =
        .scheduledTimer(timeInterval: TimeInterval(DOIPParameters.Instance.A_Doip_ctrl), target: self,   selector: (#selector(self.Timeout_Elapsed)), userInfo: nil, repeats: false)
    }
    
    func StopListening()
    {
        udpClient?.close()
        udpClient = nil
    }
    
    var ConnectedEndPoint:IPEndPoint!
    
    func StartListening(remoteEndPoint:IPEndPoint?)
    {
    
        
        IsUDPTimedOut = false
        if(Validate() && udpClient == nil)
        {
            
            let que = DispatchQueue(label: "UDPQue", qos: .background)
                udpClient = GCDAsyncUdpSocket(delegate: self, delegateQueue: que)
                do{
                    try udpClient.bind(toPort:(UInt16(DOIPSession.Instance.LOCAL_UDP_PORT)))
                    try  self.udpClient.beginReceiving()
                }
                catch{
                    udpClient = nil
            }
        
         
        }
    }
    
    
    
    public func Validate() -> Bool
    {
         ValidationErrors = ValidationRuleMessages()
     
        if(!TransportLayerHelper.NetworkAvailable())
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.NETWORK_DISCONN, MethodInfo: "Network disconnected", strAdditionalInfo: ""))
        }
        if(ValidationErrors.Messages.count > 0)
        {
            return false
        }
        else
        {
            return true
        }
    }
}
