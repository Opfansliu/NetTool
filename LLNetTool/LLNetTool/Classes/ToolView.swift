//
//  ToolView.swift
//  LLNetTool
//
//  Created by 璐 on 2022/7/28.
//

import UIKit

class ToolView: UIView {
    let toolView: UILabel = {
        let toolV = UILabel()
        toolV.text = "Tool"
        toolV.textColor = UIColor.black
        toolV.backgroundColor = UIColor.red
        toolV.isUserInteractionEnabled = true
        toolV.textAlignment = .center
        return toolV
    }()

}
