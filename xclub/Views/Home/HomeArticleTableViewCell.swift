//
//  HomeArticleTableViewCell.swift
//  xclub
//
//  Created by 姜锺超 on 2018/7/18.
//  Copyright © 2018年 姜锺超. All rights reserved.
//

import UIKit
/// 异步加载图片框架
import Kingfisher
/// 布局框架
import SnapKit

class HomeArticleTableViewCell: UITableViewCell {
    private var cellView: UIView?
    private var shadowView: UIView?
    /// 图片容器
    private var mobileImageView: UIImageView?
    private var titleLable: UILabel?
    private var describLable: UILabel?
    
    /// 图片宽高比的旧值，作用在于如果比例没有发生变化，则不会重新渲染整个视图
    private var newProportion: CGFloat = 0.4 {
        willSet{
            guard newValue == self.proportion else {
                self.proportion = newValue
                return
            }
        }
    }
    /// 图片宽高比 默认 高:宽 = 1:2
    private var proportion: CGFloat = 0.4 {
        didSet{
            /// 比例变化，重新渲染试图
            self.resetUI()
        }
    }
    
    var status: HomeArticles.list! {
        willSet{
            let url = URL(string: "\(Config.baseurl)/\(newValue!.mpic)")
            mobileImageView?.image = nil
            mobileImageView?.kf.setImage(with: url, completionHandler: {(image, error, cacheType, imageURL) in
                /// 重置宽高比
                self.newProportion = image!.size.height / image!.size.width
            })
            titleLable?.text = newValue!.title
            describLable?.text = newValue!.author
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // 整个生命周期都存在的东西，比如字体样式
        self.snp.makeConstraints{(maker) in
            maker.top.equalTo(20)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化ui
        self.setUIInit()
        self.selectionStyle = .none
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // do your thing
        ///* 阴影 设置阴影需要等待snp计算约束后执行，否则获取不到bounds */
        /// shadowPath属性设置为特定值，iOS不需要动态计算透明度
        shadowView?.layer.shadowPath = UIBezierPath.init(roundedRect: cellView!.bounds, cornerRadius: cellView!.layer.cornerRadius).cgPath
        shadowView?.layer.shadowColor = UIColor.black.cgColor // 阴影颜色
        shadowView?.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0)) // 阴影偏移
        shadowView?.layer.shadowOpacity = 0.5 // 不透明度
        shadowView?.layer.shadowRadius = 5 //设置阴影所照射的范围
        shadowView?.layer.masksToBounds = false
        shadowView?.layer.shouldRasterize = true// 设置缓存
        shadowView?.layer.rasterizationScale = UIScreen.main.scale // 设置抗锯齿边缘
        ///* 阴影 end*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("HomeArticleTableViewCell init(coder:) has not been implemented")
    }
    
    /// 根据图片宽高比重置ui size(执行过程可能会改变)
    private func resetUI() {
        
        UIView.animate(withDuration: 0.3) {
            self.mobileImageView?.snp.remakeConstraints {(maker) in
                maker.left.top.right.equalToSuperview()
                maker.height.equalTo(self.mobileImageView!.snp.width).multipliedBy(self.proportion)
                print(self.proportion)
            }
            self.setNeedsLayout()
        }
    }
    
    /// 初始化ui
    private func setUIInit() {
        /// 初始化
        shadowView = UIView()
        cellView = UIView()
        mobileImageView = UIImageView()
        titleLable = UILabel()
        describLable = UILabel()
        /// set ui
        shadowView?.backgroundColor = UIColor.clear
        cellView?.backgroundColor = UIColor.white
        /// 圆角
        cellView?.clipsToBounds = true
        cellView?.layer.cornerRadius = 5
//        cellView?.
        
        mobileImageView?.backgroundColor = UIColor.white
        
        titleLable?.backgroundColor = UIColor.clear
        titleLable?.font = UIFont.systemFont(ofSize: 16)
        titleLable?.numberOfLines = 0
        
        describLable?.backgroundColor = UIColor.clear
        describLable?.font = UIFont.systemFont(ofSize: 12)
        describLable?.textColor = UIColor(rgb: 0x999999)
        describLable?.numberOfLines = 0

        cellView?.addSubview(mobileImageView!)
        cellView!.addSubview(titleLable!)
        cellView!.addSubview(describLable!)
        shadowView?.addSubview(cellView!)
        self.addSubview(shadowView!)
        
        shadowView?.snp.makeConstraints{(maker) in
            maker.left.top.right.bottom.equalToSuperview().inset(10)
        }
        cellView?.snp.makeConstraints{(maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        mobileImageView?.snp.makeConstraints{(maker) in
            maker.left.top.right.equalToSuperview()
            maker.height.equalTo(mobileImageView!.snp.width).multipliedBy(proportion)
            print(proportion)
        }
        titleLable?.snp.makeConstraints{(maker) in
            maker.left.right.equalTo(cellView!).offset(10)
            maker.top.equalTo(mobileImageView!.snp.bottom).offset(10)
        }
        describLable?.snp.makeConstraints{(maker) in
            maker.left.right.equalTo(cellView!).offset(10)
            maker.top.equalTo(titleLable!.snp.bottom).offset(4)
            maker.bottom.equalToSuperview().inset(10)
        }
    }
}
