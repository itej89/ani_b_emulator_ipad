//
//  VehicleIdentificationWithVINDiagState.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class VehicleIdentificationWithVINDiagState:IDiagStateForSendRecieve
{
    
    public var ValidationErrors: ValidationRuleMessages
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public func _Init(arrDataToBeSent: [UInt8]?) -> Int {
//        UDPListen.Instance.StartListening(remoteEndPoint: DOIPSession.Instance.RemoteEndPoint)
        if(UDPListen.Instance.ValidationErrors.Messages.count == 0)
        {
            var data:[UInt8]? = nil
            var returnStatus:(Int, [UInt8]?) = FormatRequest()
            if(returnStatus.0 == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
            {
                data = returnStatus.1
                if(data != nil)
                {
                    returnStatus.0 = SendData(data: data!)
                }
            }
            return returnStatus.0
        }
            
        else
        {
            return DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
        }
    }
    
    private func FormatRequest() -> (Int, [UInt8]?)
    {
        var data:[UInt8]? = nil
        
        let formatRequest:DOIPFrameSynthesizer = DOIPFrameSynthesizer()
        let request:DOIPRequestObject = formatRequest.FormHeaderForDoIPFrame(payloadType: Request_Payload_Types.CODE.PLD_VEH_IDEN_REQ_VIN)
        let payload:Payload_Vehicle_Request_VIN = Payload_Vehicle_Request_VIN()
        payload.SetVIN(VIN: DOIPParameters.Instance.VIN)
        request.SetPayload(_Payload: payload)
        
        data  = formatRequest.CreateDOIPFrame(DOIPObject: request)
        
        return (DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue, data)
        
    }
    
    public func HandleIncomingData(objResponse: DOIPResponseObject?) -> (Int, [UInt8]?) {
        var retStatus = -1
        let bufferResponse:[UInt8]? = nil
        
        if(objResponse != nil)
        {
            DOIPSession.Instance.ProtocolVersion = objResponse!.GetProtocolVersion()
            
            let Payload:Payload_Vehicle_Announcement? = (objResponse!.GetPayload() as! Payload_Vehicle_Announcement)
            
            if(Payload != nil)
            {
                DOIPSession.Instance.RespondedDOIPEntityCachedData.VIN = (Payload?.GetVIN())!
                DOIPSession.Instance.RespondedDOIPEntityCachedData.EID = (Payload?.GetEID())!
                DOIPSession.Instance.RespondedDOIPEntityCachedData.GID = (Payload?.GetGID())!
                DOIPSession.Instance.RespondedDOIPEntityCachedData.LogicalAddress = Payload!.GetlogicalAddress()!
                DOIPSession.Instance.RespondedDOIPEntityCachedData.FurtherActions = Payload!.GetFurtherAction()
                
                if(Payload!.ValidationErrors.Messages.count > 0)
                {
                    retStatus = DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
                    return (retStatus, bufferResponse!)
                }
                
                DOIPAccessImplementation.Instance.ContextConvey.FoundDOIPEntity(Entity: DOIPSession.Instance.RespondedDOIPEntityCachedData)
                
                DOIPSession.Instance.RespondedDOIPEntityCachedData = nil
                
                return (retStatus, bufferResponse)
            }
            else
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Vehicle Identification Response Payload"))
                return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
            }
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Vehicle Identification Response Object"))
            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
        }
    }
    
    public func SendData(data:[UInt8]) -> Int
    {
        UDPRequest.Instance.Send(packet: data)
        if(UDPRequest.Instance.ValidationErrors.Messages.count > 0)
        {
            return DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
        }
        else
        {
            return DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue
        }
    }
    
    
    
}

