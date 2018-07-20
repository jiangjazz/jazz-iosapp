//
//  Banner.swift
//  xclub
//
//  Created by 姜锺超 on 2018/7/18.
//  Copyright © 2018年 姜锺超. All rights reserved.
//

import UIKit

//enum HomeData {
//    case banner(Banner.list)
//    case article(HomeArticles.list)
//}

protocol HomeData {
}

/// swift4.0 原生支持JSON语法
struct Banner: HomeData, Codable {
    /// 请求是否成功
    let success: Int
    /// 列表数据
    let lists: [list]
    
    /// 列表数据模型
    struct list: Codable {
        /// 帖子id
        let tid: Int
        /// 标题
        let title: String
        /// 发帖时间
        let dateline: Date
        /// 图片路径
        let mpic: String
        /// 排序
        let displayorder: Int
    }
}
