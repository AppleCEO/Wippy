//
//  HeaderTableViewCell.swift
//  nrise
//
//  Created by joon-ho kil on 2019/12/31.
//  Copyright © 2019 joon-ho kil. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let ID = "MainTableViewCell"
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "NanumBarunGothicBold", size: 16)
        return nameLabel
    }()
    let mobileValidationLabel: UILabel = {
        let mobileValidationLabel = UILabel()
        mobileValidationLabel.font = UIFont(name: "NanumBarunGothic", size: 11)
        return mobileValidationLabel
    }()
    let mobileVelidationImageView: UIImageView = {
        let mobileVelidationImageView = UIImageView()
        mobileVelidationImageView.image = UIImage(named: "profile_phone_mark_icon")
        mobileVelidationImageView.isHidden = true
        return mobileVelidationImageView
    }()
    let locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont(name: "NanumBarunGothic", size: 14)
        return locationLabel
    }()
    let mainInfoLabel: UILabel = {
        let mainInfoLabel = UILabel()
        mainInfoLabel.font = UIFont(name: "NanumBarunGothic", size: 14)
        return mainInfoLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(nameLabel)
        self.addSubview(mobileValidationLabel)
        self.addSubview(mobileVelidationImageView)
        self.addSubview(locationLabel)
        self.addSubview(mainInfoLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(9)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(mobileVelidationImageView.snp.leading).offset(-5)
            make.width.lessThanOrEqualTo(180)
            make.height.equalTo(19)
        }
        
        mobileValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
            make.width.equalTo(76)
            make.height.equalTo(13)
        }
        
        mobileVelidationImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(11)
            make.trailing.equalTo(mobileValidationLabel.snp.leading).offset(-4)
            make.width.height.equalTo(15)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        mainInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func putInfo(model: Model) {
        nameLabel.text = model.name
        if model.isVerifyMobile {
            self.mobileValidationLabel.text = "전화번호 인증됨"
            self.mobileVelidationImageView.isHidden = false
        }
        locationLabel.text = model.location+", "+model.distance
        mainInfoLabel.text = model.height+"cm, "+model.bloodType+", "+model.religion
    }
}
