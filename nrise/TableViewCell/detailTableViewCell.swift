//
//  InfoTableViewCell.swift
//  nrise
//
//  Created by joon-ho kil on 2019/12/31.
//  Copyright © 2019 joon-ho kil. All rights reserved.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    static let ID = "DetailTableViewCell"
    
    lazy var firstTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "NanumBarunGothic", size: 13)
        titleLabel.textColor = UIColor(red: 162/255.0, green: 162/255.0, blue: 162.0, alpha: 1)
        return titleLabel
    }()
    lazy var firstContentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont(name: "NanumBarunGothic", size: 13)
        return contentLabel
    }()
    lazy var secondTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "NanumBarunGothic", size: 13)
        titleLabel.textColor = UIColor(red: 162/255.0, green: 162/255.0, blue: 162.0, alpha: 1)
        return titleLabel
    }()
    lazy var secondContentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont(name: "NanumBarunGothic", size: 13)
        return contentLabel
    }()
    lazy var thirdTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "NanumBarunGothic", size: 13)
        titleLabel.textColor = UIColor(red: 162/255.0, green: 162/255.0, blue: 162.0, alpha: 1)
        return titleLabel
    }()
    lazy var thirdContentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont(name: "NanumBarunGothic", size: 13)
        contentLabel.numberOfLines = 3
        return contentLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.firstTitleLabel)
        self.addSubview(self.firstContentLabel)
        self.addSubview(self.secondTitleLabel)
        self.addSubview(self.secondContentLabel)
        self.addSubview(self.thirdTitleLabel)
        self.addSubview(self.thirdContentLabel)
        
        self.firstTitleLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(20)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(firstContentLabel.snp.leading).offset(-5)
        }
        
        self.firstContentLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(20)
            make.leading.equalTo(self.snp.centerX).multipliedBy(0.7)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        self.secondTitleLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(firstTitleLabel.snp.bottom).offset(23)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(secondContentLabel.snp.leading).offset(-5)
        }
        
        self.secondContentLabel.snp.remakeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp.centerX).multipliedBy(0.7)
            make.top.equalTo(firstContentLabel.snp.bottom).offset(22)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        
        self.thirdTitleLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(secondTitleLabel.snp.bottom).offset(23)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(thirdContentLabel.snp.leading).offset(-5)
        }
        
        self.thirdContentLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(secondContentLabel.snp.bottom).offset(22)
            make.leading.equalTo(self.snp.centerX).multipliedBy(0.7)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        firstTitleLabel.text = nil
        firstContentLabel.text = nil
        secondTitleLabel.text = nil
        secondContentLabel.text = nil
        thirdTitleLabel.text = nil
        thirdContentLabel.text = nil
    }
    
    func putInfo(model: Model, indexPath: IndexPath) {
        if indexPath.row == 1 {
           firstTitleLabel.text = "학교"
           firstContentLabel.text = model.educationLevel
           secondTitleLabel.text = "직업"
           secondContentLabel.text = model.basicOccupation
           thirdTitleLabel.text = "내소개"
           thirdContentLabel.text = model.resultDescription
       } else {
           firstTitleLabel.text = "종교"
           firstContentLabel.text = model.religion
           secondTitleLabel.text = "음주"
           secondContentLabel.text = model.alcohol
           thirdTitleLabel.text = "흡연"
           thirdContentLabel.text = model.smoke
       }
    }
}
