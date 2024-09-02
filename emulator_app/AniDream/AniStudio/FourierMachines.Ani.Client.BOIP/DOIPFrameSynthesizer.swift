//
//  DOIPFrameSynthesizer.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIPFrameSynthesizer
{
    public func CreateDOIPFrame(DOIPObject:DOIPRequestObject!) -> [UInt8]!
    {
        var DOIPFrame:[UInt8] = [UInt8]()
        
        if(DOIPObject != nil)
        {
            var PayloadLength:Int32 = 0
            var DOIPPayload:[UInt8]!
            
            if(DOIPObject.GetPayload() != nil)
            {
                PayloadLength = Int32((DOIPObject.GetPayload().TotalNumberOfBytesInPayload()))
                
                if(PayloadLength > 0)
                {
//                    DOIPFrame = [UInt8](repeating: 0, count: DOIPRequestObject.GetHeaderLength() + Int(PayloadLength))
                    DOIPPayload = DOIPObject.GetPayload()?.Make_Payload()
                }
                else
                {
                    return nil
                }
            }
            else
            {
//                DOIPFrame = [UInt8](repeating: 0, count: DOIPRequestObject.GetHeaderLength())
            }
            
//            DOIPFrame[0] = DOIPObject.GetProtocolVersion()
//            DOIPFrame[1] = DOIPObject.GetInverseProtocolVersion()
            
            DOIPFrame.append(DOIPObject.GetProtocolVersion())
            DOIPFrame.append(DOIPObject.GetInverseProtocolVersion())
            
            var PayloadTypeArray = Request_Payload_Types.Instance.Encode(Paylod_Type: DOIPObject.GetPayLoadType())
            PayloadTypeArray.reverse()
            
            var PayloadLengthArray = toByteArray(PayloadLength)
            PayloadLengthArray.reverse()
            
            
            DOIPFrame.append(contentsOf: PayloadTypeArray)
            DOIPFrame.append(contentsOf: PayloadLengthArray)
            
//            DOIPFrame.replaceSubrange(2..<2+PayloadTypeArray.count, with: PayloadTypeArray)
//            DOIPFrame.replaceSubrange(4..<4+PayloadLengthArray.count, with:  PayloadLengthArray)
//
            if(DOIPPayload != nil)
            {
                DOIPFrame.append(contentsOf: DOIPPayload)
//                DOIPFrame.replaceSubrange(DOIPRequestObject.GetHeaderLength()..<DOIPRequestObject.GetHeaderLength()+DOIPPayload.count, with: DOIPPayload)
            }
        }
        
        return DOIPFrame
    }
    
    func toByteArray<T>(_ value: T) -> [UInt8] {
        var value = value
        return withUnsafeBytes(of: &value) { Array($0) }
    }
    
    public func FormHeaderForDoIPFrame(payloadType:Request_Payload_Types.CODE) -> DOIPRequestObject
    {
        let request:DOIPRequestObject = DOIPRequestObject()
        if(payloadType == Request_Payload_Types.CODE.PLD_VEH_IDEN_REQ ||
            payloadType == Request_Payload_Types.CODE.PLD_VEH_IDEN_REQ_VIN ||
            payloadType == Request_Payload_Types.CODE.PLD_VEH_IDEN_REQ_EID)
        {
            request.SetProtocolVersion(_ProtocolVersion: DOIPSession.Instance.DefaultProtocolVersion)
        }
        else
        {
             request.SetProtocolVersion(_ProtocolVersion: DOIPSession.Instance.ProtocolVersion)
        }
        
        request.SetPayloadType(_Req_Payload_Type: payloadType)
        return request
    }
    
}
