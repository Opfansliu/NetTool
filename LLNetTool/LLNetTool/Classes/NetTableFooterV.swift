//
//  NetTableHeaderV.swift
//  DebugTools
//
//  Created by 璐 on 2022/7/22.
//

import UIKit
import SnapKit

@objc protocol NetTableFooterVDelegate {
    func closeBtnClick()
    func clearBtnClick()
}

class NetTableFooterV: UITableViewHeaderFooterView {
    var delegate: NetTableFooterVDelegate?
    lazy var clearBtn: UIButton = {
       let btn = UIButton()
        btn.setTitle("清除", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.yellow, for: .normal)
        btn.addTarget(self, action: #selector(clearBtnClick), for: .touchUpInside)
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var closeBtn: UIButton = {
       let btn = UIButton()
        btn.setTitle("退出", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.yellow, for: .normal)
        btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NetTableFooterV {
    func configUI(){
        addSubview(clearBtn)
        addSubview(closeBtn)
        clearBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
//        clearBtn.snp.makeConstraints { make in
//            make.right.equalTo(-16)
//            make.centerY.equalTo(self.snp.centerY)
//            make.width.equalTo(60)
//        }
        closeBtn.snp.makeConstraints { make in
            make.left.equalTo(clearBtn.snp.left).offset(-80)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(60)
        }
        
    }
    
    @objc func closeBtnClick() {
        if (self.delegate != nil){
            self.delegate?.closeBtnClick()
        }
        
    }
    
    @objc func clearBtnClick() {
        print("点击清除")
        if (self.delegate != nil) {
            self.delegate?.clearBtnClick()
        }
        
    }
}
