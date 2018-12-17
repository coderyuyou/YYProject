//
//  HUDViewController.swift
//  YYProject
//
//  Created by 于优 on 2018/12/11.
//  Copyright © 2018 SuperYu. All rights reserved.
//

import UIKit
import SnapKit

class HUDViewController: YYBaseViewController {
    
    let dataArray:[String] = ["LoadingStyleDeterminate", "LoadingStyleHorizontalBar", "LoadingStyleAnnularDeterminate", "showPlainText", "showSuccess", "showError", "showIcon", "showCustomView"]
    
    let toolCell = "toolCell"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
    }
    
    func createView() {
        navView.title = "HUD"
        navView.seperateColor = UIColor.lightGray
        
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: toolCell)
        tableView.separatorStyle = .singleLine
        
//        tableView.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(navView.snp.bottom).offset(0)
//            make.left.bottom.right.equalTo(view)
//        }
        
        tableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(navView.snp.bottom).offset(0)
            ConstraintMaker.left.bottom.right.equalTo(view)
        }
    }
    
    // MARK:-TableView
    
   override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: toolCell, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            YYProgressHUD.showLoading(YYHUDLoadingStyleDeterminate, message: "加载中...")
        case 1:
            YYProgressHUD.showLoading(YYHUDLoadingStyleDeterminateHorizontalBar, message: "加载中...")
        case 2:
            YYProgressHUD.showLoading(YYHUDLoadingStyleAnnularDeterminate, message: "加载中...")
        case 3:
            YYProgressHUD.showPlainText("文字提醒", view: view)
        case 4:
            YYProgressHUD.showSuccess("已关注", to: view)
        case 5:
            YYProgressHUD.showError("操作失败", to: view)
        case 6:
            let image = UIImage(named: "contacts")
            YYProgressHUD.showIcon(image!, message: "自定义icon")
        case 7:
            let btn = UIButton(type: UIButton.ButtonType.custom)
            btn.backgroundColor = UIColor.darkGray
            btn.layer.cornerRadius = 6.0
            btn.clipsToBounds = true
            btn.setTitle("确定", for:UIControl.State.normal)
            btn.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
            btn.setTitleColor(UIColor.white, for: .normal)
            YYProgressHUD.showCustomView(btn, hideAfterDelay: 2)
        default:
            break
        }
    }
}

