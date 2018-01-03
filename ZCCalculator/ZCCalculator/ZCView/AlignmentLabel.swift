//
//  AlignmentLabel.swift
//  ZCCalculator
//
//  Created by 赵隆杰 on 2018/1/4.
//  Copyright © 2018年 赵隆杰. All rights reserved.
//

import UIKit

class AlignmentLabel: UILabel {

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bounds.maxY - textRect.size.height
        return textRect
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines))
    }
}
