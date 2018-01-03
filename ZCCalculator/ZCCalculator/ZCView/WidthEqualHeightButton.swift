//
//  WidthEqualHeightButton.swift
//  ZCCalculator
//
//  Created by 赵隆杰 on 2018/1/4.
//  Copyright © 2018年 赵隆杰. All rights reserved.
//

import UIKit

class WidthEqualHeightButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
    }
    

}
