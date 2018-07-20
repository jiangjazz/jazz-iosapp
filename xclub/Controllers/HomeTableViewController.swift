//
//  HomeTableViewController.swift
//  xclub
//
//  Created by 姜锺超 on 2018/7/18.
//  Copyright © 2018年 姜锺超. All rights reserved.
//

import UIKit
import SnapKit

class HomeTableViewController: UITableViewController {
    /// tablecell数据源
    var cells: [[HomeData]] = [[], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 自动计算tablecell高度
        self.tableView.estimatedRowHeight = CGFloat(self.view.frame.size.width / 2)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        /// 加载banner
        self.getBanner()
        /// 加载推荐文章列表
        self.getArticles()
    }
    
    /// 加载banner
    func getBanner() -> Void {
        Networking.sharedNetWorking.parameters = ["fid": Config.fid]
        Networking.requestGet(url: APIS.Home.banner, finish: {(success, data) in
            if success {
                let decoder = JSONDecoder()
                let res = try! decoder.decode(Banner.self, from: data)
                
                guard res.success != 1 else {
                    self.cells[0] = [res]
                    self.tableView.reloadData()
                    return
                }
            }
        })
    }
    /// 加载推荐文章列表
    func getArticles() -> Void {
        Networking.sharedNetWorking.parameters = ["fid": Config.fid]
        Networking.requestGet(url: APIS.Home.articles, finish: {(success, data) in
            if success {
                let decoder = JSONDecoder()
                let res = try! decoder.decode(HomeArticles.self, from: data)
                
                guard res.success != 1 else {
                    self.cells[1] = res.lists
                    self.tableView.reloadData()
                    return
                }
            }
        })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 1:
            return cells[1].count
        default:
            return cells[0].count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cells[indexPath.section][indexPath.row]
        if let model = cellModel as? Banner {
            /// banner
            var cell = tableView.dequeueReusableCell(withIdentifier: "HomeBannerTableViewCell") as? HomeBannerTableViewCell
            if cell == nil {
                cell = HomeBannerTableViewCell(style: .default, reuseIdentifier: "HomeBannerTableViewCell")
            }
            cell?.status = model
            return cell!
        } else if let model = cellModel as? HomeArticles.list {
            /// 推荐文章列表
            var cell = tableView.dequeueReusableCell(withIdentifier: "HomeArticleTableCell") as? HomeArticleTableViewCell
            if cell == nil {
                cell = HomeArticleTableViewCell(style: .default, reuseIdentifier: "HomeArticleTableCell")
            }
            cell?.status = model
            return cell!
        } else {
            fatalError("No such type")
        }
    }
    
//    测试代码
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 50
//    }
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        view.backgroundColor = UIColor.red
//        return view
//    }

}
