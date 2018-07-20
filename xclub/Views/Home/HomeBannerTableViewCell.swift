//
//  HomeBannerTableViewCell.swift
//  xclub
//
//  Created by 姜锺超 on 2018/7/19.
//  Copyright © 2018年 姜锺超. All rights reserved.
//

import UIKit
/// 异步加载图片框架
import Kingfisher
/// 轮播图
import LLCycleScrollView

class HomeBannerTableViewCell: UITableViewCell {
    /// 图片轮播容器
    private var scrollView: LLCycleScrollView?
    /// 监控状态，改变则更改整个视图
    var status: Banner! {
        willSet{
//            scrollView?.imagePaths =
            var imagePaths: Array<String> = []
            for dic in newValue!.lists {
                imagePaths.append("\(Config.baseurl)/\(dic.mpic)")
            }
            scrollView?.imagePaths = imagePaths
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("HomeArticleTableViewCell init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setUI() {
        // 初始化
        scrollView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width / 2))
        // 是否自动滚动
        scrollView?.autoScroll = true
        // 是否无限循环，此属性修改了就不存在轮播的意义了 😄
        scrollView?.infiniteLoop = true
        // 滚动间隔时间(默认为2秒)
        scrollView?.autoScrollTimeInterval = 3.0
        // 等待数据状态显示的占位图
        scrollView?.placeHolderImage = UIImage(named: "home")
        // 如果没有数据的时候，使用的封面图
        scrollView?.coverImage =  UIImage(named: "home")
        // 设置图片显示方式=UIImageView的ContentMode
        scrollView?.imageViewContentMode = .scaleToFill
        // 设置滚动方向（ vertical || horizontal ）
        scrollView?.scrollDirection = .horizontal
        // 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
        scrollView?.customPageControlStyle = .snake
        // 非.system的状态下，设置PageControl的tintColor
        scrollView?.customPageControlInActiveTintColor = UIColor.white
        scrollView?.customPageControlTintColor = UIColor(rgb: 0x009944)
        // 设置.system系统的UIPageControl当前显示的颜色
        scrollView?.pageControlCurrentPageColor = UIColor.white
        // 非.system的状态下，设置PageControl的间距(默认为8.0)
        scrollView?.customPageControlIndicatorPadding = 8.0
        // 设置PageControl的位置 (.left, .right 默认为.center)
        scrollView?.pageControlPosition = .center
        // 背景色
        scrollView?.collectionViewBackgroundColor = UIColor.red
        
        // 添加到view
        self.addSubview(scrollView!)
        self.selectionStyle = .none
        scrollView?.snp.makeConstraints{(maker) in
            maker.left.top.right.bottom.equalToSuperview()
            maker.height.equalTo(scrollView!.snp.width).multipliedBy(0.5)
        }
    }
}
