//
//  ImageAnimationState.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class ImageAnimationState: AnimationState
{
    
    public var AnimationKind:AnimationType = AnimationType.NA
    
    public var TargetObject: AnimationObject = AnimationObject.NA
    
    public class TransformMatrix
    {
        public var a:[Double : Bool] = [0.0 : false];
        public var b:[Double : Bool] = [0.0 : false];
        public var c:[Double : Bool] = [0.0 : false];
        public var d:[Double : Bool] = [0.0 : false];
        public var tx:[Double : Bool] = [0.0 : false];
        public var ty:[Double : Bool] = [0.0 : false];
        
        
        public var m13:[Double : Bool] = [0.0 : false];
        public var m14:[Double : Bool] = [0.0 : false];
        public var m23:[Double : Bool] = [0.0 : false];
        public var m24:[Double : Bool] = [0.0 : false];
        public var m31:[Double : Bool] = [0.0 : false];
        public var m32:[Double : Bool] = [0.0 : false];
        public var m33:[Double : Bool] = [0.0 : false];
        public var m34:[Double : Bool] = [0.0 : false];
        public var m43:[Double : Bool] = [0.0 : false];
        public var m44:[Double : Bool] = [0.0 : false];
    }
    
    public class CircularCurve
    {
        var MidX:[Double : Bool] = [0.0 : false];
        var MidY:[Double : Bool] = [0.0 : false];
        var Radius:[Double : Bool] = [0.0 : false];
        var StartAngle:[Double : Bool] = [0.0 : false];
        var EndAngle:[Double : Bool] = [0.0 : false];
        var Direction:[CircularPathDirection : Bool] = [CircularPathDirection.clockwise : false];
    }
    
    public  var Matrix:TransformMatrix = TransformMatrix()
    public  var CircularPath:CircularCurve = CircularCurve()
    
    public var opacity:[Double : Bool] = [1.0 : false];
    public var centreX:[Double : Bool] = [0.0 : false];
    public var centreY:[Double : Bool] = [0.0 : false];
    public var AnchorX:[Double : Bool] = [0.0 : false];
    public var AnchorY:[Double : Bool] = [0.0 : false];
    
    public override func parseJson(json : NSDictionary)
    {
        
        let dictionary =  json["AnimationState"] as! NSDictionary
        
        AnimationKind = AnimationTypeStringToOptions[dictionary["AnimationKind"] as! String]!
        
        
        var dictionaryProperty =  dictionary["a"] as! NSDictionary
        
        Matrix.a = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["b"] as! NSDictionary
        
        Matrix.b = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["c"] as! NSDictionary
        
        Matrix.c = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["d"] as! NSDictionary
        
        Matrix.d = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["tx"] as! NSDictionary
        
        Matrix.tx = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["ty"] as! NSDictionary
        
        Matrix.ty = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        
        
        
        
        
        
        
        dictionaryProperty =  dictionary["MidX"] as! NSDictionary
        
        CircularPath.MidX = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["MidY"] as! NSDictionary
        
        CircularPath.MidY = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["Radius"] as! NSDictionary
        
        CircularPath.Radius = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["StartAngle"] as! NSDictionary
        
        CircularPath.StartAngle = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["EndAngle"] as! NSDictionary
        
        CircularPath.EndAngle = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["Direction"] as! NSDictionary
        
        CircularPath.Direction = [CircularPathDirectionStringToOptions[dictionaryProperty["key"] as! String]! : Bool(dictionaryProperty["value"] as! String)!]
        
        
        
        
        
        
        
        
        
        dictionaryProperty =  dictionary["opacity"] as! NSDictionary
        
        opacity = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["centreX"] as! NSDictionary
        
        centreX = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["centreY"] as! NSDictionary
        
        centreY = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["AnchorX"] as! NSDictionary
        
        AnchorX = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
        dictionaryProperty =  dictionary["AnchorY"] as! NSDictionary
        
        AnchorY = [Double(dictionaryProperty["key"] as! String)! : Bool(dictionaryProperty["value"] as! String)!]
        
    }
    
    
    
   public override func Json() -> String{
        
        var json = ""
        
        json.append("{ \"AnimationState\" : {")
        
        
        
        json.append(" \"AnimationKind\" : \""+AnimationKind.description+"\" , ")
        
        
        
        json.append(" \"a\" : {")
        json.append(String(" \"key\" : \""+String(describing : Matrix.a.keys.first!)+"\" , "+" \"value\" : \""+String(describing: Matrix.a.values.first!)+"\"  },"))
        
        
        json.append(" \"b\" : {")
        json.append(String(" \"key\" : \""+String(describing : Matrix.b.keys.first!)+"\" , "+" \"value\" : \""+String(describing: Matrix.b.values.first!)+"\"  },"))
        
        
        json.append(" \"c\" : {")
        json.append(String(" \"key\" : \""+String(describing : Matrix.c.keys.first!)+"\" , "+" \"value\" : \""+String(describing: Matrix.c.values.first!)+"\"  },"))
        
        
        json.append(" \"d\" : {")
        json.append(String(" \"key\" : \""+String(describing : Matrix.d.keys.first!)+"\" , "+" \"value\" : \""+String(describing: Matrix.d.values.first!)+"\"  },"))
        
        
        json.append(" \"tx\" : {")
        json.append(String(" \"key\" : \""+String(describing : Matrix.tx.keys.first!)+"\" , "+" \"value\" : \""+String(describing: Matrix.tx.values.first!)+"\"  },"))
        
        json.append(" \"ty\" : {")
        json.append(String(" \"key\" : \""+String(describing : Matrix.ty.keys.first!)+"\" , "+" \"value\" : \""+String(describing: Matrix.ty.values.first!)+"\"  },"))
        
        
        
        
        
        json.append(" \"MidX\" : {")
        json.append(String(" \"key\" : \""+String(describing : CircularPath.MidX.keys.first!)+"\" , "+" \"value\" : \""+String(describing: CircularPath.MidX.values.first!)+"\"  },"))
        
        
        json.append(" \"MidY\" : {")
        json.append(String(" \"key\" : \""+String(describing : CircularPath.MidY.keys.first!)+"\" , "+" \"value\" : \""+String(describing: CircularPath.MidY.values.first!)+"\"  },"))
        
        
        json.append(" \"StartAngle\" : {")
        json.append(String(" \"key\" : \""+String(describing : CircularPath.StartAngle.keys.first!)+"\" , "+" \"value\" : \""+String(describing: CircularPath.StartAngle.values.first!)+"\"  },"))
        
        
        json.append(" \"EndAngle\" : {")
        json.append(String(" \"key\" : \""+String(describing : CircularPath.EndAngle.keys.first!)+"\" , "+" \"value\" : \""+String(describing: CircularPath.EndAngle.values.first!)+"\"  },"))
        
        
        json.append(" \"Radius\" : {")
        json.append(String(" \"key\" : \""+String(describing : CircularPath.Radius.keys.first!)+"\" , "+" \"value\" : \""+String(describing: CircularPath.Radius.values.first!)+"\"  },"))
        
        let direction:String = (CircularPath.Direction.keys.first?.description)!
        
        json.append(" \"Direction\" : {")
        json.append(String(" \"key\" : \""+direction+"\" , "+" \"value\" : \""+String(describing: CircularPath.Direction.values.first!)+"\"  },"))
        
        
        
        
        
        
        
        
        
        json.append(" \"opacity\" : {")
        json.append(String(" \"key\" : \""+String(describing : opacity.keys.first!)+"\" , "+" \"value\" : \""+String(describing: opacity.values.first!)+"\"  },"))
        
        
        json.append(" \"centreX\" : {")
        json.append(String(" \"key\" : \""+String(describing : centreX.keys.first!)+"\" , "+" \"value\" : \""+String(describing: centreX.values.first!)+"\"  },"))
        
        
        json.append(" \"centreY\" : {")
        json.append(String(" \"key\" : \""+String(describing : centreY.keys.first!)+"\" , "+" \"value\" : \""+String(describing: centreY.values.first!)+"\"  },"))
        
        
        json.append(" \"AnchorX\" : {")
        json.append(String(" \"key\" : \""+String(describing : AnchorX.keys.first!)+"\" , "+" \"value\" : \""+String(describing: AnchorX.values.first!)+"\"  },"))
        
        
        json.append(" \"AnchorY\" : {")
        json.append(String(" \"key\" : \""+String(describing : AnchorY.keys.first!)+"\" , "+" \"value\" : \""+String(describing: AnchorY.values.first!)+"\"  }"))
        
        
        json.append(" }")
        
        json.append("}")
        
        return json
        
    }
    
    
    
    
    
    override init(){}
    
    init(_TargetObject: AnimationObject,
         _a:[Double : Bool],
         _b:[Double : Bool],
         _c:[Double : Bool],
         _d:[Double : Bool],
         _tx:[Double : Bool],
         _ty:[Double : Bool],
         _opacity:[Double : Bool],
         _centreX:[Double : Bool],
         _centreY:[Double : Bool],
         _anchorX:[Double : Bool],
         _anchorY:[Double : Bool]
        )
    {
        TargetObject = _TargetObject
        Matrix.a = _a
        Matrix.b = _b
        Matrix.c = _c
        Matrix.d = _d
        Matrix.tx = _tx
        Matrix.ty = _ty
        opacity = _opacity
        centreX = _centreX
        centreY = _centreY
        AnchorX = _anchorX
        AnchorY = _anchorY
    }
    
}

