//
//  DB_Table_Columns.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 01/02/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation


public class DB_Table_Columns
{
    
 public static let DEFAULT_EM_SYNTH_ID:Int = 1
    
  public  enum  DBTables :String {
        case NO_DATA //Used to indicate a table that is not present oin DB
        case SERVO_DATA
        case SERVO_TURN
        case SERVO_LIFT
        case SERVO_LEAN
        case SERVO_TILT
        case CAPTURED_COMMANDS
        case EXPRESSIONS
        case ACTS
        case BEATS
        case CONTEXT
        case MACHINE_POSITIONS
        case TRACK
        case EM_SYNTH
        
    }
    
    public enum DBCONTEXT_KEYS : String
    {
        case EM_SYNTH_ID
        case EMOTION_NAME
        case ACT_ID
        case BEAT_ID
    }
    
    enum CONTEXT_COLUMNS :String
    {
        case KEY
        case VALUE
    }
    
    enum EM_SYNTH :String
    {
        case ID
        case NAME
    }
    
    enum MACHINE_POSITIONS_COLUMNS :String
    {
        case NAME
        case TURN
        case LIFT
        case LEAN
        case TILT
    }
    
    enum SERVO_DATA_COLUMNS :String
    {
        case NAME
        case ADDRESS
        case MIN_ANGLE
        case MAX_ANGLE
    }
    
    enum SERVO_CALIBRATION_COLUMNS :String
    {
        case DEGREE
        case ADC
    }
    
    enum CAPTURED_COMMAND_COLUMNS :String
    {
        case NAME
        case COMMAND
    }
    
    
    enum EXPRESSIONS_COLUMNS :String
    {
        case ID
        case NAME
        case ACTION_DATA
        case JOY
        case SURPRISE
        case FEAR
        case SADNESS
        case ANGER
        case DISGUST
        case EM_SYNTH_ID
        case SOUND_ID
    }
    
    enum ACTS_COLUMNS :String
    {
        case ACT_ID
        case ACT_NAME
        case ACT_AUDIO
    }
    
    enum BEATS_COLUMNS :String
    {
        case BEAT_ID
        case ACT_ID
        case ACTION_DATA
        case JOY
        case SURPRISE
        case FEAR
        case SADNESS
        case ANGER
        case DISGUST
        case StartSec
        case EndSec
    }
    enum COLUMN_TYPES :String
    {
        case TEXT
        case NUMBER
        case FLOAT
        case BLOB
    }
    
    enum TRACK_COLUMNS :String{
        case TRACK_ID
        case DATA
    }
    
 
}
