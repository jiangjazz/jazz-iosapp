//
//  Extension.swift
//  xclub
//
//  Created by 姜锺超 on 2018/7/20.
//  Copyright © 2018年 姜锺超. All rights reserved.
//

import Foundation
import UIKit


// MARK: - 扩展UIColor，接受rgb参数
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
