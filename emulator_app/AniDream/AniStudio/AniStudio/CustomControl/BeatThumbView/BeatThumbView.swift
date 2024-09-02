//
//  BeatThumbView.swift
//  AniStudio
//
//  Created by Tej Kiran on 14/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

public class BeatThumbView:UIView
{
    var beatSelectedProtocol:BeatSelectedProtocol!
    public func Initialize(_beatSelectedProtocol:BeatSelectedProtocol, TopSpace:CGFloat, height:CGFloat, Tag:Int)
    {
        beatSelectedProtocol = _beatSelectedProtocol
        
        //Add gesture recog. to view
        let viewTapped = UITapGestureRecognizer(target: self, action: #selector(ViewTapHandler(gesture:)))
        viewTapped.numberOfTapsRequired = 1
        self.addGestureRecognizer(viewTapped)
        
        //Set Background color to view
        self.backgroundColor = UIColor(red:0xFF/255, green:0xC0/255, blue:0xCb/255, alpha: 1)
        self.layer.frame = CGRect(x: 0, y: TopSpace, width: 100, height: height)
        
        
       
        
        //SetTag
        self.tag = Tag
    }
    
    override public func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if newWindow == nil {
            // UIView disappear
        } else {
            //Create SubView
            let thumbSubView = UIView()
            
            //Add gesture recog. to subview
            let subviewTapped = UITapGestureRecognizer(target: self, action: #selector(SubViewTapHandler(gesture:)))
            subviewTapped.numberOfTapsRequired = 1
            thumbSubView.addGestureRecognizer(subviewTapped)
            
            //Set Background color to subview
            thumbSubView.backgroundColor = UIColor(red:0xBD/255, green:0xCC/255, blue:0xCC/255, alpha: 1)
            thumbSubView.frame = CGRect(x: 0, y: self.bounds.height/4, width:  3*self.bounds.width/4, height:   self.bounds.height/2)
            
            
            thumbSubView.tag = self.tag
            
            //SetSubView
            self.addSubview(thumbSubView)
        }
    }
    
    public func UnselectThumb()
    {
         self.backgroundColor = UIColor(red:0xFF/255, green:0xC0/255, blue:0xCb/255, alpha: 1)
        self.subviews[0].backgroundColor = UIColor(red:0xBD/255, green:0xCC/255, blue:0xCC/255, alpha: 1)
    }
    
    public func SelectThumb()
    {
    self.backgroundColor = UIColor(red:0xFF/255, green:0xFF/255, blue:0x66/255, alpha: 1)
    self.subviews[0].backgroundColor = UIColor(red:0x99/255, green:0x00/255, blue:0x00/255, alpha: 1)
    }
    
    @objc func SubViewTapHandler(gesture: UITapGestureRecognizer) {
        
        if(beatSelectedProtocol != nil)
        {
            beatSelectedProtocol.BeatSelected(view: self)
        }
        SelectThumb()
    }
    
    @objc func ViewTapHandler(gesture: UITapGestureRecognizer) {
        if(beatSelectedProtocol != nil)
        {
            beatSelectedProtocol.BeatSelected(view: self)
        }
        SelectThumb()
       
    }
}
