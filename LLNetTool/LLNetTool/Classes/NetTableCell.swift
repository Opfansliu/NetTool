//
//  NetTableCell.swift
//  DebugTools
//
//  Created by 璐 on 2022/7/22.
//

import UIKit
import SnapKit


class NetTableCell: UITableViewCell {
//    lazy var title: UILabel = {
//       let title = UILabel()
//        title.font = UIFont.systemFont(ofSize: 16)
//        title.numberOfLines = 2
//        return title
//    }()
    
    lazy var contentBgV: UIScrollView = {
       let contentBgV = UIScrollView()
        return contentBgV
    }()
    
    lazy var contentLable: UILabel = {
       let contentL = UILabel()
        contentL.text = ""
        contentL.textColor = UIColor.red
        contentL.font = UIFont.systemFont(ofSize: 14)
        contentL.numberOfLines = 0
        return contentL
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension NetTableCell {
    func configUI() {
        let screenW = UIScreen.main.bounds.size.width
        contentView.addSubview(contentBgV)
        contentBgV.addSubview(contentLable)
        contentBgV.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.bottom.equalToSuperview()
        }
        contentLable.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(screenW)
        }
        contentBgV.contentSize = CGSize(width: screenW - 32, height: 300)
    }
}
