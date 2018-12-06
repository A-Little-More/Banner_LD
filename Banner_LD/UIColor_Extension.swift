//
//  UIColor_Extension.swift
//  Banner_LD
//
//  Created by lidong on 2018/12/5.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
        
    }
    
    //随机颜色类方法
    static func randomColor() -> UIColor {
        
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)), a: 1)
        
    }
    
}
