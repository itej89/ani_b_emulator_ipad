//
//  ElasticEase.h.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class ElasticEase:EasingBase
{
      var _period, _amplitude:Double
    
    public override init()
    {
        _amplitude=0
        _period = 0
    }
    
    override public func easeIn(time_:Double) -> Double
    {
        
       var p,a,s:Double;
      
        
        if(time_==0)
        {
        return 0;
        }
        
        var ctime =  time_/_duration;
        
        if(ctime==1)
        {
        return _change
        }
        
        if(_period == 0)
        {
        p=_duration*0.3
        }
        else
        {
        p=_period
        }
        
        a=_amplitude;
        if(a==0 || a<fabs(_change))
        {
            a=_change;
            s=p/4;
        }
        else
        {
        s=p/(2 * .pi)*asin(_change/a);
        }
        
        ctime = ctime - 1
        return -(a*pow(2,10*ctime)*sin((ctime*_duration-s)*(2 * .pi)/p));
    }
    
    
    /*
     * Ease out
     */
    
    override public  func easeOut(time_:Double) -> Double
    {
        var p,a,s:Double;
        
        
        if(time_==0)
        {
            return 0;
        }
        
        var ctime =  time_/_duration;
        
        if(ctime==1)
        {
            return _change
        }
        
        if(_period == 0)
        {
            p=_duration*0.3
        }
        else
        {
            p=_period
        }
        
        a=_amplitude;
        if(a==0 || a<fabs(_change))
        {
            a=_change;
            s=p/4;
        }
        else
        {
            s=p/(2 * .pi)*asin(_change/a);
        }
        
        ctime = ctime - 1
        return (a*pow(2,-10*ctime)*sin((ctime*_duration-s)*(2 * .pi)/p))+_change;
    }
    
    
    /*
     * Ease in and out
     */
    
    override public  func easeInOut(time_:Double) -> Double
    {
        var p,a,s:Double;
        
        
        if(time_==0)
        {
            return 0;
        }
        
        var ctime =  time_/(_duration/2);
        
        if(ctime==2)
        {
            return _change
        }
        
        if(_period == 0)
        {
            p=_duration*0.3*1.5
        }
        else
        {
            p=_period
        }
        
        a=_amplitude;
        if(a==0 || a<fabs(_change))
        {
            a=_change;
            s=p/4;
        }
        else
        {
            s=p/(2 * .pi)*asin(_change/a);
        }
        
        
        if(ctime < 1)
        {
             return -0.5*(a*pow(2,10*ctime)*sin((ctime*_duration-s)*(2 * .pi)/p));
        }
        
        ctime  = ctime  - 1
        
             return 0.5*(a*pow(2,-10*ctime)*sin((ctime*_duration-s)*(2 * .pi)/p))+_change;
        
    }
    
    func setPeriod(period_:Double)
    {
    _period=period_;
    }
    
    
    /*
     * Set the amplitude
     */
    
    func setAmplitude(amplitude_:Double)
    {
    _amplitude=amplitude_;
    }
}
