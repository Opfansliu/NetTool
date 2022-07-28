//
//  NetTableVC.swift
//  DebugTools
//
//  Created by 璐 on 2022/7/22.
//

import UIKit
import SnapKit

let cell_identifier: String = "NetTableViewCell"
let netTableFooter_identifier: String = "NetTableFooter"

class NetTableVC: UIViewController {
    var dataSource: NSArray = []
    var tableview: UITableView = {
       let tableview = UITableView()
        tableview.register(NetTableCell.self, forCellReuseIdentifier: cell_identifier)
        tableview.tableFooterView = UIView()
        tableview.register(NetTableFooterV.self, forHeaderFooterViewReuseIdentifier: netTableFooter_identifier)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    
    }
    

}

extension NetTableVC {
    func configUI() {
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        tableview.dataSource = self
        tableview.delegate = self
        dataSource =  LLNetData.config().allObject() as NSArray
    }
}

extension NetTableVC: UITableViewDataSource, UITableViewDelegate {
  
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footV: NetTableFooterV = tableview.dequeueReusableHeaderFooterView(withIdentifier: netTableFooter_identifier) as! NetTableFooterV
        footV.delegate = self
        return footV
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableview.dequeueReusableCell(withIdentifier: cell_identifier) as? NetTableCell
        if (cell == nil) {
            cell = NetTableCell()
        }
        let urlString = dataSource[indexPath.row] as? String
        cell?.contentLable.text = urlString
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension NetTableVC : NetTableFooterVDelegate {
    func closeBtnClick() {
        self.dismiss(animated: true)
    }
    func clearBtnClick() {
        LLNetData.config().removeAllObject()
        tableview.reloadData()
        
    }
    
}
