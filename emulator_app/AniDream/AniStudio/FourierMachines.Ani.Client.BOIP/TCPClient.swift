//
//  TCPClient.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit
import CocoaAsyncSocket

public class TcpClient : NSObject, IValidation, GCDAsyncSocketDelegate
{
    public func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        AsyncStartListening()
        }
   
    
       public func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        if(self.ClientConvey != nil)
        {
            
            let date = Date()
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            print("Rx :  = \(hour):\(minutes):\(seconds)")
            
            
            self.ClientConvey.DataRecieved(recievedData: RecievedData(_RemoteEndPoint: IPEndPoint(_IPAddress: sock.connectedHost!, _Port: Int(sock.connectedPort)),  _recvBuffer: [UInt8](data)))
        }
        }
        
      public func send(_ data: Data) {
        
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("Tx :  = \(hour):\(minutes):\(seconds)")
        
        self.tcpSocket?.write(data, withTimeout: -1, tag: 0)
       
    }
    

    var tcpSocket: GCDAsyncSocket?
    
    
    var TimeOut:Timer!
    var _TimeInterval:Int = 0
    var Timeout_return_code:Int = 0
    
    public var ValidationErrors: ValidationRuleMessages = ValidationRuleMessages()
    
    public var IsTCPConnected:Bool = false
    
    public var ClientConvey:TransportClientConvey!
    
    override init()
    {
        super.init()
        TimeOut = Timer()
    }
    
    public static var Instance:TcpClient = TcpClient()
    
    public func TcpClientInit()
    {
        if(Validate())
        {
            _TimeInterval = Int((DOIPParameters.Instance.DOIP_TCP_RESPONSE_WAIT_TIME))
            Timeout_return_code = DIAGNOSTIC_STATUS.CODE.TCP_TIMEOUT.rawValue
        }
    }
    
   
    
    public func TryConnect() -> Bool
    {
        if(tcpSocket != nil && tcpSocket!.isConnected)
        {
                    return true
            
        }
        
        let que = DispatchQueue(label: "TcpQue", qos: .background)
        self.tcpSocket = GCDAsyncSocket(delegate: self, delegateQueue: que)
        
        var IsSocketOpen = false
        
        do {
           
            try tcpSocket!.connect(toHost: DOIPSession.Instance.RemoteEndPoint.IPAddress, onPort: (UInt16(DOIPSession.Instance.RemoteEndPoint.Port)), withTimeout: 5.0)
            
            IsSocketOpen  = true
        } catch let error {
            print("Cannot open socket to \(DOIPSession.Instance.RemoteEndPoint.IPAddress):\(DOIPSession.Instance.RemoteEndPoint.Port): \(error)")
        }
    
        if(IsSocketOpen)
        {
            return true
        }
     return false
    }
    
    public func CloseTCPConnection()
    {
        if(tcpSocket != nil && tcpSocket!.isConnected)
        {
            tcpSocket?.disconnect()
        }
    }
    
    public func StartListeningTimeOut()
    {
        TimeOut = .scheduledTimer(timeInterval: TimeInterval(_TimeInterval), target: self,   selector: (#selector(self.Timeout_Elapsed)), userInfo: nil, repeats: false)
    }
    
    public func AsyncStartListening()
    {
        let que = DispatchQueue(label: "", qos: .background)
        que.async{
            while(self.tcpSocket != nil && self.tcpSocket!.isConnected)
            {
                if(self.TimeOut != nil)
                {
                self.TimeOut.invalidate()
                }
                 self.tcpSocket?.readData( withTimeout: -1, tag: 53)

                usleep(1000)
            }
            print(self.tcpSocket?.isConnected)
            if(self.ClientConvey != nil)
            {
                self.ClientConvey.Disconnected()
            }
        }
        
    }
    
    public func SendData(data:[UInt8])
    {
        if(ValidateBeforeSend())
        { print("Tx count : ",String(data.count))
            send(Data(bytes: UnsafeRawPointer(data), count: data.count))
           
            StartListeningTimeOut()
        }
    }
    
    public func Disconnect()
    {
        TimeOut = nil
        CloseTCPConnection()
    }
    
    public func Validate() -> Bool
    {
        ValidationErrors = ValidationRuleMessages()
        if(DOIPSession.Instance.RemoteEndPoint.IPAddress == "" || DOIPSession.Instance.RemoteEndPoint.Port == -1)
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Remote end point empty", strAdditionalInfo: ""))
        }
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
    
    public func ValidateBeforeSend() -> Bool
    {
        ValidationErrors = ValidationRuleMessages()
        if(DOIPSession.Instance.RemoteEndPoint.IPAddress == "" || DOIPSession.Instance.RemoteEndPoint.Port == -1)
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Remote end point empty", strAdditionalInfo: ""))
        }
        if(!TransportLayerHelper.NetworkAvailable())
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.NETWORK_DISCONN, MethodInfo: "Networkk disconnected", strAdditionalInfo: ""))
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
    
   @objc func Timeout_Elapsed() {
        TimeOut.invalidate()
        if(ClientConvey != nil)
        {
            ClientConvey.Timeout(code: Timeout_return_code)
        }
    }
}
