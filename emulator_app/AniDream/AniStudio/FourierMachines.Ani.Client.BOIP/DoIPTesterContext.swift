//
//  DoIPTesterContext.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 01/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DoIPTesterContext:TransportClientConvey
{
   
    var payloadType_DiagState:[Response_Payload_Types.CODE:IDiagState] = [
        Response_Payload_Types.CODE.PLD_VEH_IDEN_RES:VehicleIdentificationDiagState(),
        Response_Payload_Types.CODE.PLD_ROUTING_ACTIVATION_RES:RoutingActivationDiagState(),
        Response_Payload_Types.CODE.PLD_DIAG_MESSAGE:DiagnosticMessagesDiagState(),
        Response_Payload_Types.CODE.PLD_DIAG_MESSAGE_NEGATIVE_ACK:DiagMessageNAKDiagState(),
        Response_Payload_Types.CODE.PLD_DIAG_MESSAGE_POSITIVE_ACK:DiagMessagePosACKDiagState(),
        Response_Payload_Types.CODE.PLD_DOIP_HEADER_NAK:GenericHeaderNAKDiagState(),
        Response_Payload_Types.CODE.PLD_ALIVE_CHECK_REQ:AliveCheckDiagState(),
        Response_Payload_Types.CODE.PLD_DIAG_POWER_MODE_RES:DiagPowerModeDiagState(),
        Response_Payload_Types.CODE.PLD_DOIP_ENTITY_STATUS_RES:DoIPEntityStatusDiagState(),
        ]
    var identificationType_DiagState:[Vehicle_Identification_Types.CODE:IDiagState] = [
        Vehicle_Identification_Types.CODE.VEHICLE_IDENTIFICATION:VehicleIdentificationDiagState(),
        Vehicle_Identification_Types.CODE.VEHICLE_IDENTIFICATION_EID:VehicleIdentificationWithEIDDiagState(),
        Vehicle_Identification_Types.CODE.VEHICLE_IDENTIFICATION_VIN:VehicleIdentificationWithVINDiagState(),
    ]
    
    var DOIPBuffer:[(status:Bool,object:DOIPResponseObject?)] = []
    
    var IsVehicleIdentificationResponseRecieved = false
    
    var StopRoutingActivationLoop = true
    var RoutingActivationLoopStopped = true
    var RoutingActivationLoopStarted = false
    
    
    var StopDataParsingLoop = true
    var DataParsingStopped = true
    var DataParsingStarted = false
    
    var _currentState:IDiagState?
    public func getCurrentState() -> IDiagState?
    {
        return self._currentState
    }
    public func setCurrentState(newState:IDiagState)
    {
        _currentState = newState
    }
    
    var _previousState:IDiagState?
    public func getPreviousState() -> IDiagState?
    {
        return self._previousState
    }
    public func setPreviousState(oldState:IDiagState)
    {
        _previousState = oldState
    }
    
     init()
    {
        TcpClient.Instance.ClientConvey = self
        UDPListen.Instance.UDPClientConvey = self
    }
    
    public var TCPDataBuffer:[RecievedData] = []
    public var DOIPFrameBuffer:(Bool, [UInt8]?)? = (false, nil)
    
    public func ParseTCPData(recData:RecievedData)
    {
        var i = 0
        while(i < TCPDataBuffer.count)
        {
            if(TCPDataBuffer[i].RemoteEndPoint.IPAddress == recData.RemoteEndPoint.IPAddress && TCPDataBuffer[i].RemoteEndPoint.Port == recData.RemoteEndPoint.Port)
            {
                
                
                
                while(TCPDataBuffer[i].recvBuffer.count >= DOIPResponseObject.Number_Of_Bytes_In_Header)
                {
                    let parser:DOIPFrameParser = DOIPFrameParser()
                    let objRespone:DOIPResponseObject = parser.Parse(DOIPFrame: TCPDataBuffer[i].recvBuffer)
                    objRespone.EndPoint = TCPDataBuffer[i].RemoteEndPoint
                    if(DOIPResponseObject.Number_Of_Bytes_In_Header + objRespone.GetPayloadLength() == TCPDataBuffer[i].recvBuffer.count)
                    {
                        self.DOIPBuffer.append((status: true, object: objRespone))
                        self.TCPDataBuffer.remove(at: i)
                        i = i - 1
                        break
                    }
                    else
                    {
                        if(DOIPResponseObject.Number_Of_Bytes_In_Header+objRespone.GetPayloadLength() < TCPDataBuffer[i].recvBuffer.count)
                        {
                            let FirstFrameLength:Int = DOIPResponseObject.Number_Of_Bytes_In_Header + objRespone.GetPayloadLength()
                            DOIPBuffer.append((status: true, object: objRespone))
                            TCPDataBuffer[i].recvBuffer.replaceSubrange(0...FirstFrameLength, with: [])
                        }
                        else
                        {
                            break
                        }
                    }
                }
                break
            }
            
            i = i + 1
        }
        
        
            
           
        
    }
    
    public var ContextConvey:DOIPContextConvey!
    public var ResultConvey:DOIPContextResultConvey!
    
    //DOIP Communication Initializing sequence
    public func _Initialize(_ContextConvey:DOIPContextConvey,_ResultConvey:DOIPContextResultConvey) -> Int
    {
         ResultConvey = _ResultConvey
         ContextConvey = _ContextConvey
         UDPListen.Instance.StartListening(remoteEndPoint: nil)
        StartDataParser()
        return DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue
    }
    
    public func _UnInitialize()
    {
        
        UDPListen.Instance.StopListening()
        TcpClient.Instance.Disconnect()
    }
    
    public func AnnounceDiscover() -> Int
    {
        
        let typeCode:Vehicle_Identification_Types.CODE = Vehicle_Identification_Types.Instance.DECODE(Vehicle_Identification_Value: DOIPParameters.Instance.DOIP_IDENTIFICATION_MODE)
        
        if(identificationType_DiagState[typeCode] != nil)
        {
            setCurrentState(newState: identificationType_DiagState[typeCode]!)
        }
        
        if(typeCode == Vehicle_Identification_Types.CODE.VEHICLE_IDENTIFICATION || typeCode == Vehicle_Identification_Types.CODE.VEHICLE_IDENTIFICATION_EID || typeCode == Vehicle_Identification_Types.CODE.VEHICLE_IDENTIFICATION_VIN)
        {
            DOIPSession.Instance.RemoteEndPoint = IPEndPoint(_IPAddress: DOIPParameters.Instance.DOIP_Entity_IPAddress, _Port: DOIPParameters.Instance.DOIP_ENTITY_UDP_DISCOVER)
        }
        
        return MoveNext()
    }
    
    public func RoutingActivation(Entity:DOIPEntity) -> Int
    {
        DOIPSession.Instance.TargetAddress = Entity.LogicalAddress
        DOIPSession.Instance.FurtherAction = Entity.FurtherActions
        DOIPSession.Instance.UDSRequestType = ADDRESSING_TYPES.UDSRequestType.UDS
        DOIPSession.Instance.RemoteEndPoint = IPEndPoint(_IPAddress: Entity.IPAddress, _Port: DOIPParameters.Instance.DOIP_ENTITY_UDP_DISCOVER)
        setCurrentState(newState: RoutingActivationDiagState())
        return MoveNext()
    }
    
    private func HandleIncomingData(data:DOIPResponseObject?)
    {
        let responseCode = data?.GetPayLoadType()
        
            if(payloadType_DiagState.keys.contains((data?.GetPayLoadType())!))
            {
                setCurrentState(newState: payloadType_DiagState[responseCode!]!)
            }
        
        
        let returnStatus = _currentState?.HandleIncomingData(objResponse: data)
        
        if(returnStatus!.0 != (DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue))
        {
            if(ResultConvey != nil)
            {
                ResultConvey.InitializeResultNotify(result: returnStatus!.0)
            }
        }
    }
    
    private func HandleDiagnostic(objResponse:DOIPResponseObject?)
    {
        if(objResponse != nil)
        {
            setCurrentState(newState: payloadType_DiagState[Response_Payload_Types.CODE.PLD_DIAG_MESSAGE]!)
            
            let returnStatus = _currentState?.HandleIncomingData(objResponse: objResponse)
            
            if(ContextConvey != nil)
            {
                ResultConvey.UDSSendResultNotify(result: returnStatus!.0)
            }
        }
    }
    
    private func HandleDiagAcknowledgement(data:DOIPResponseObject?)
    {
        if(data != nil)
        {
            if(type(of: _currentState) != type(of: payloadType_DiagState[data!.GetPayLoadType()]) )
            {
                if(payloadType_DiagState.keys.contains(data!.GetPayLoadType()))
                {
                    setCurrentState(newState: payloadType_DiagState[data!.GetPayLoadType()]!)
                }
                
                let returnStatus = _currentState?.HandleIncomingData(objResponse: data)
                
                if(ResultConvey != nil)
                {
                    if(returnStatus!.0 != DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
                    {
                        if(TcpClient.Instance.tcpSocket != nil && TcpClient.Instance.tcpSocket!.isConnected)
                        {
                            ResultConvey.UDSSendResultNotify(result: returnStatus!.0)
                        }
                    }
                    else
                    {
                        ResultConvey.UDSSendResultNotify(result: returnStatus!.0)
                        DOIPFrameBuffer = nil
                    }
                }
                
            }
        }
    }
    
    public func MoveNext(dataToBeSent:[UInt8]? = nil) -> Int
    {
        return (_currentState as! IDiagStateForSendRecieve)._Init(arrDataToBeSent: dataToBeSent)
    }
    
    public func StartDataParser()
    {
        let que = DispatchQueue(label: "", qos: .background)
        que.async{
            self.StopDataParsingLoop = false
            self.DataParsingStopped = false
            self.DataParsingStarted  = true
             while(!self.StopDataParsingLoop)
             {
                var i = 0
                while i < self.DOIPBuffer.count {
                    if(self.DOIPBuffer[i].object == nil)
                    {
                        self.DOIPBuffer.remove(at: i)
                         i = i - 1
                        continue
                    }
                    if(self.DOIPBuffer[i].object!.GetPayLoadType() == Response_Payload_Types.CODE.DOIPTester_UNKNOWN_CODE)
                    {
                        self.DOIPBuffer.remove(at: i)
                        i = i - 1
                    }
                    else if(self.DOIPBuffer[i].status)
                    {
                        if(DoIPGenericHeaderHandler.Instance.ValidateHeader(objResponse: self.DOIPBuffer[i].object))
                        {
                            if(self.DOIPBuffer[i].object!.GetPayLoadType() == Response_Payload_Types.CODE.PLD_DIAG_MESSAGE_POSITIVE_ACK || self.DOIPBuffer[i].object!.GetPayLoadType() == Response_Payload_Types.CODE.PLD_DIAG_MESSAGE_NEGATIVE_ACK)
                            {
                                self.HandleDiagAcknowledgement(data: self.DOIPBuffer[i].object)
                            }
                            else if(self.DOIPBuffer[i].object!.GetPayLoadType() == Response_Payload_Types.CODE.PLD_DIAG_MESSAGE)
                            {
                                self.HandleDiagnostic(objResponse: self.DOIPBuffer[i].object)
                            }
                            else
                            {
                                self.HandleIncomingData(data: self.DOIPBuffer[i].object)
                            }
                            self.DOIPBuffer.remove(at: i)
                            i = i - 1
                        }
                    }
                    
                    i = i + 1
                }
                
                usleep(1000)
            }
            
            if(self.StopDataParsingLoop)
            {
                self.DataParsingStopped = true
                self.DataParsingStarted = false
            }
        }
    }
    
    public func StartCheckkForTCPConnectionAlive()
    {
        let que = DispatchQueue(label: "", qos: .background)
        que.async{
            self.RoutingActivationLoopStopped = false
            self.StopRoutingActivationLoop = false
            self.RoutingActivationLoopStarted  = true
            while(!self.StopRoutingActivationLoop)
            {
                if(TcpClient.Instance.tcpSocket != nil && !TcpClient.Instance.tcpSocket!.isConnected)
                {
                    self.ResultConvey?.LinkDisconnected()
                    break
                }
                else
                {
                    if(self.DOIPFrameBuffer?.0 == true && TcpClient.Instance.tcpSocket!.isConnected)
                    {
                        self.DOIPFrameBuffer!.0 = false
                        let result = self.SendUDSRequest(dataToBeSent: self.DOIPFrameBuffer!.1!)

                        self.ResultConvey.UDSSendResultNotify(result: result)
                    }
                }
                usleep(1000)
            }

            if(self.StopRoutingActivationLoop)
            {
                self.RoutingActivationLoopStopped = true
                self.RoutingActivationLoopStarted = false
            }
        }
    }
    
    
    public func SendData(Data:[UInt8]) -> Int
    {
      
        DOIPFrameBuffer = (true, Data)
        TCPDataBuffer = []
        
        return DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue
    }
    
    public func SendUDSRequest(dataToBeSent:[UInt8]) -> Int
    {
        
      
        var ReturnStatus = -1
        var retryCount = 0
        let MaxTransmitRetry = DOIPParameters.Instance.DOIP_DIAG_NO_ACK_REPEAT_NUM
       repeat
        {
            setCurrentState(newState: payloadType_DiagState[Response_Payload_Types.CODE.PLD_DIAG_MESSAGE]!)
            ReturnStatus = MoveNext(dataToBeSent: dataToBeSent)
            retryCount = retryCount + 1
       }while ((ReturnStatus == DIAGNOSTIC_STATUS.CODE.DIAG_ACK_TIMEOUT.rawValue) && (retryCount <= MaxTransmitRetry))
        
        return ReturnStatus
    }
    
    public func FianlizeDiag()
    {
//        StopDataParsingLoop = true
        StopRoutingActivationLoop = true
        TcpClient.Instance.Disconnect()
        if(RoutingActivationLoopStarted)
        {
            while(!RoutingActivationLoopStopped)
            {
                usleep(10000)
            }
        }
//        if(DataParsingStarted)
//        {
//            while(!DataParsingStopped)
//            {
//                usleep(10000)
//            }
//        }
        
    }
    
    
    
    
    //TransportClientConvey
    
    public func Disconnected() {
        FianlizeDiag()
        if(ResultConvey != nil)
        {
            ResultConvey.LinkDisconnected()
        }
    }
    
    public func DataRecieved(recievedData: RecievedData) {
        if(recievedData.recvBuffer.count > 0)
        {
               if(DOIPSession.Instance.RespondedDOIPEntityCachedData != nil)
               {
                DOIPSession.Instance.RespondedDOIPEntityCachedData.IPAddress = recievedData.RemoteEndPoint.IPAddress
                DOIPSession.Instance.RespondedDOIPEntityCachedData.Port = recievedData.RemoteEndPoint.Port
            }
            
            var IsFilled = false
            
            for recData in TCPDataBuffer
            {
                if(recData.RemoteEndPoint.IPAddress == recievedData.RemoteEndPoint.IPAddress &&
                recData.RemoteEndPoint.Port == recievedData.RemoteEndPoint.Port)
                {
                    recData.recvBuffer.append(contentsOf: recievedData.recvBuffer)
                    self.ParseTCPData(recData: recData)
                    IsFilled = true
                    break
                }
            }
            
            if(!IsFilled)
            {
                TCPDataBuffer.append(recievedData)
                self.ParseTCPData(recData: recievedData)
            }
        }
        else
        {
            ResultConvey.UDSSendResultNotify(result: DIAGNOSTIC_STATUS.CODE.INVALID_HEADER.rawValue)
        }
    }
    
    public func Timeout(code: Int) {
        if(code  == DIAGNOSTIC_STATUS.CODE.DIAG_ACK_TIMEOUT.rawValue)
        {
             ResultConvey.UDSSendResultNotify(result: code)
        }
        else
        {
            ResultConvey.InitializeResultNotify(result: code)
        }
    }
    //End of TransportClientConvey
}
