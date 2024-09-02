//
//  CommandHelper.swift
//  BoltBot
//
//  Created by Uday on 04/02/17.
//  Copyright © 2017 itej89. All rights reserved.
//

//export PATH=~/anaconda/bin:$PATH

import Foundation

public class CommandHelper
{
  public  func CreateCommand(Address: String, Angle: String) -> String {
        
        return "ANG#"+Address+"#"+Angle+":"
    }
    
  public  func GetResponseCountForCommand(CommandType: String) -> Int {
        return CommandResponseCount[CommandType]!
    }
    
    
    
 public   var CommandResponseCount:[String:Int] = [
        CommandTypes.ANG.rawValue:1,
        CommandTypes.TMG.rawValue:1,
        CommandTypes.TRG.rawValue:1,
        CommandTypes.DEG.rawValue:2,
        CommandTypes.ATC.rawValue:1,
        CommandTypes.DTC.rawValue:1,
        CommandTypes.LLK.rawValue:1,
        CommandTypes.RLK.rawValue:1,
        CommandTypes.EAS.rawValue:1,
        CommandTypes.INO.rawValue:1,
        CommandTypes.PRX.rawValue:2,
        CommandTypes.CELL1.rawValue:2,
        CommandTypes.CELL2.rawValue:2,
        CommandTypes.CELL3.rawValue:2,
        CommandTypes.SLEEP.rawValue:2,
        CommandTypes.VEN.rawValue:1,
        CommandTypes.VNO.rawValue:1,
        CommandTypes.CPW.rawValue:1,
        CommandTypes.DPW.rawValue:1,
        CommandTypes.LAT.rawValue:1,
        CommandTypes.LDT.rawValue:1,
        CommandTypes.LOF.rawValue:1,
        CommandTypes.LON.rawValue:1,
        CommandTypes.SMV.rawValue:2,
        CommandTypes.FRQ.rawValue:1,
        CommandTypes.DEL.rawValue:1,
        CommandTypes.DMP.rawValue:1,
        CommandTypes.VEL.rawValue:1,
        CommandTypes.ISLR.rawValue:2,
        CommandTypes.ISLW.rawValue:2,
        CommandTypes.ISLER.rawValue:2,
        CommandTypes.ISLEW.rawValue:2,
        ]
    
 public   enum EasingFunction :String{
     case SIN,
        QAD,
        LIN,
        EXP,
        ELA,
        CIR,
        BOU,
        BAK,
        TRI,
        TRW,
        SNW,
        SPR
        
        
    }
    
  public static var EasingFunctionArray: [EasingFunction] = [EasingFunction.SIN, EasingFunction.QAD, EasingFunction.LIN, EasingFunction.EXP, EasingFunction.ELA, EasingFunction.CIR,
                                                 EasingFunction.BOU, EasingFunction.BAK,
                                                 EasingFunction.TRI, EasingFunction.TRW,
                                                 EasingFunction.SNW, EasingFunction.SPR]
    
  public  enum EasingType :String{
        case IN = "IN",
        OU = "OU",
        IO = "IO"
    }
    
  public static var EasingTypeArray: [EasingType] = [EasingType.IN, EasingType.OU, EasingType.IO]
    
    
 public  static func  GetEasingFunciton(rawvalue: String) -> EasingFunction {
        return EasingFunction(rawValue: rawvalue)!
    }
    
 public  static func  GetEasingType(rawvalue: String) -> EasingType {
        return EasingType(rawValue: rawvalue)!
    }
    
 public   enum CommandTypes :String {
        case ANG // Servo command to set angle in PWM ANG#6#544;
        case TMG // Servo command to set TIMING TMG#6#1000;
        case TRG // Command to trigger servo motion
        case DEG // Command to read current Servo angle in ADC
        case ATC //Attach Servo
        case DTC //Detach Servo
        case LLK // Set Left Lock Servo Angle in PWM
        case RLK // Set Right Lock Servo Angle in PWM
        case EAS //Set Servo Easing Func
        case INO // Set SErvo Easing Type
        case PRX // read promity sensor.. Support sonly 9 address
        case CELL1 //Read CELL1 value in ADC
        case CELL2//Read CELL2 value in ADC
        case CELL3//Read CELL3 value in ADC
        case SLEEP
        case VEN//Set Voice LED Fade
        case VNO//Stop Voice LED Fade
        case CPW//Connect servo Power
        case DPW//Disconnect servo power
        case LAT//Attach lock servos
        case LDT//Detach lock servos
        case LON//Power on lock servos
        case LOF//power off lock servos
        case SMV //REad if servo is moving or not
        case FRQ //Sets the frequency of animation waveforms
        case DEL //Sets the delay before motor starts animation
        case DMP //range 1-10 sets the damping level of spring waveform motion
        case VEL //range 1-5  set the velocity of spring waveform motion
        case ISLR //Reads Data from ISL94203 RAM Address
        case ISLW //Writes Data to ISL94203 RAM Address
        case ISLER //Reads Data from ISL94203 EEPROM Address
        case ISLEW //Writes Data to ISL94203 EEPROM Address
    }
   

    
    
  }

