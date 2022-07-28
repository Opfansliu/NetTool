//
//  ToolController.swift
//  DebugTools
//
//  Created by 璐 on 2022/7/21.
//

import UIKit

class ToolController: UIViewController {
    lazy var btn: UIButton = {
       let btn = UIButton()
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.backgroundColor = UIColor.red
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(btn)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }
}

extension ToolController {
    @objc func btnClick()  {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


