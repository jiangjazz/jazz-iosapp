//
//  APIS.swift
//  xclub
//
//  Created by 姜锺超 on 2018/7/18.
//  Copyright © 2018年 姜锺超. All rights reserved.
//

import Foundation

/// api接口路径
struct APIS {
    /// 首页
    struct Home {
        /// banner
        static let banner = "/plugin.php?id=banners_manage"
        /// articles
        static let articles = "/plugin.php?id=recom_threads"
    }
}
