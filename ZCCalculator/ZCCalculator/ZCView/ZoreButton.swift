//
//  ZoreButton.swift
//  ZCCalculator
//
//  Created by 赵隆杰 on 2018/1/4.
//  Copyright © 2018年 赵隆杰. All rights reserved.
//

import UIKit

class ZoreButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code
        layer.cornerRadius = (bounds.width - 8) / 4
        clipsToBounds = true
        
        let left = (bounds.width - 8) / 2
        titleEdgeInsets = UIEdgeInsetsMake(0, -left, 0, 0)
        
    }
    
    
    

}
