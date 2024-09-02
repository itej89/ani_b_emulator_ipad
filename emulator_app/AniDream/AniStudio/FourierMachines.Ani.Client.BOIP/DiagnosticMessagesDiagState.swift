//
//  DiagnosticMessagesDiagState.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 01/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DiagnosticMessagesDiagState:IDiagStateForSendRecieve
{
    
    public var ValidationErrors: ValidationRuleMessages
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public func _Init(arrDataToBeSent: [UInt8]?) -> Int {
        var retStatus = FormatRequest(userData: arrDataToBeSent!)
        if(retStatus.0 == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
        {
            if(retStatus.1 != nil)
            {
                
               
            retStatus.0 = SendData(data: retStatus.1!)
            }
        }
        return  (retStatus.0)
    }
    
    private func FormatRequest(userData:[UInt8]) -> (Int, [UInt8]?)
    {
        var data:[UInt8]? = nil
        
        let formatRequest:DOIPFrameSynthesizer = DOIPFrameSynthesizer()
        
        let objDiagnosticMessagePayload:Payload_Diagnostic_Message = Payload_Diagnostic_Message()
        
        objDiagnosticMessagePayload.SetSourceAddress(SA: DOIPParameters.Instance.TesterAddress)
        
        if(DOIPSession.Instance.UDSRequestType == ADDRESSING_TYPES.UDSRequestType.UDS)
        {
            if(DOIPSession.Instance.DaignosticMessageType == ADDRESSING_TYPES.MessageType.PHYSICAL)
            {
                objDiagnosticMessagePayload.SetTArgetAddress(TA: DOIPSession.Instance.TargetAddress)
            }
            else
            {
                if(DOIPSession.Instance.DaignosticMessageType == ADDRESSING_TYPES.MessageType.FUNCTIONAL)
                {
                    objDiagnosticMessagePayload.SetTArgetAddress(TA: DOIPParameters.Instance.FunctionaTargetAddress)
                }
            }
        }
            else
            {
               if(DOIPSession.Instance.UDSRequestType == ADDRESSING_TYPES.UDSRequestType.TESTER_PRESENT)
                {
                    objDiagnosticMessagePayload.SetTArgetAddress(TA: DOIPParameters.Instance.TesterPresentTargetAddress)
                }
            }
        
        objDiagnosticMessagePayload.SetUserData(User_Data: userData)
        
        if(objDiagnosticMessagePayload.ValidationErrors.Messages.count > 0)
        {
            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, data)
        }
        
        let request:DOIPRequestObject = formatRequest.FormHeaderForDoIPFrame(payloadType: Request_Payload_Types.CODE.PLD_DIAG_MESSAGE)
        
        request.SetPayload(_Payload: objDiagnosticMessagePayload)
        
        var date = Date()
        var calendar = Calendar.current
        
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        var seconds = calendar.component(.second, from: date)
        print("create header begin :  = \(hour):\(minutes):\(seconds)")
        
        data = formatRequest.CreateDOIPFrame(DOIPObject: request)
        
        
         date = Date()
         calendar = Calendar.current
         hour = calendar.component(.hour, from: date)
         minutes = calendar.component(.minute, from: date)
         seconds = calendar.component(.second, from: date)
        print("create header end  :  = \(hour):\(minutes):\(seconds)")
        return (DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue, data)
        
    }
    
    public func HandleIncomingData(objResponse: DOIPResponseObject?) -> (Int, [UInt8]?) {
        var retStatus = -1
        var bufferResponse:[UInt8]? = nil
        
        if(objResponse != nil)
        {
            let Payload:Payload_Diagnostic_Message? = (objResponse!.GetPayload() as! Payload_Diagnostic_Message)
            
            if(Payload != nil)
            {
                bufferResponse = Payload?.GetUserData()
                
                if(Payload!.ValidationErrors.Messages.count > 0)
                {
                    retStatus = DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
                    return (retStatus, bufferResponse)
                }
                else
                {
                    
                    DOIPSession.Instance.LastDiagnosticResponseData = bufferResponse
                    if(DOIPSession.Instance.LastDiagnosticResponseData != nil)
                    {
                    DOIPAccessImplementation.Instance.ContextConvey.UDSResponseRecieved(response: DOIPSession.Instance.LastDiagnosticResponseData!)
                    }
                    return (DIAGNOSTIC_STATUS.CODE.COMPLETE.rawValue, bufferResponse)
                }
                
            }
            else
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Diagnostic Message Response Payload"))
                return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
            }
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Diagnostic Message Response Object"))
            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
        }
    }
    
    public func SendData(data:[UInt8]) -> Int
    {
        TcpClient.Instance._TimeInterval = Int(DOIPParameters.Instance.A_Doip_Diagnostic_Message)
        TcpClient.Instance.Timeout_return_code = DIAGNOSTIC_STATUS.CODE.DIAG_ACK_TIMEOUT.rawValue
        
        TcpClient.Instance.SendData(data: data)
        if(TcpClient.Instance.ValidationErrors.Messages.count > 0)
        {
            return DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
        }
        else
        {
            return DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue
        }
    }
}
