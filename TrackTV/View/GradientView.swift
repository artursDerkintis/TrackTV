//
//  GradientView.swift
//  Starfly
//
//  Created by Arturs Derkintis on 15/12/2016.
//  Copyright © 2016 Arturs Derkintis. All rights reserved.
//
import UIKit


// Gradient effect view that can be designable in storyboard or xibs
@IBDesignable class GradientView: UIView {
    @IBInspectable var topColor : UIColor = .red
    @IBInspectable var bottomColor : UIColor = .orange
    @IBInspectable var topLocation : CGFloat = 1.0
    @IBInspectable var bottomLocation : CGFloat = 0.0
    @IBInspectable var vertical : Bool = true
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let context = UIGraphicsGetCurrentContext(){
            let colors = [bottomColor.cgColor, topColor.cgColor]
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            let colorLocations = [topLocation, bottomLocation]
            
            if let gradient = CGGradient(colorsSpace: colorSpace,
                                         colors: colors as CFArray,
                                         locations: colorLocations){
                
                let startPoint = CGPoint.zero
                let endPoint = CGPoint(x: vertical ? 0 : self.bounds.width, y: vertical ? self.bounds.height : 0)
                context.drawLinearGradient(gradient,
                                           start: startPoint,
                                           end: endPoint,
                                           options: CGGradientDrawingOptions(rawValue: UInt32(0)))
            }
        }
    }
}
