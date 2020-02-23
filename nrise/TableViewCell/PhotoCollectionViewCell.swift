//
//  PhotoCollectionViewCell.swift
//  nrise
//
//  Created by joon-ho kil on 2019/12/31.
//  Copyright © 2019 joon-ho kil. All rights reserved.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let ID = "PhotoCollectionViewCell"
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)

        self.addSubview(self.profileImageView)
        self.profileImageView.contentMode = .scaleAspectFit
        self.profileImageView.clipsToBounds = true
        self.profileImageView.snp.remakeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        } 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
