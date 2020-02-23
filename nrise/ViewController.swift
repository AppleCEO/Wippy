//
//  ViewController.swift
//  nrise
//
//  Created by joon-ho kil on 2019/12/31.
//  Copyright © 2019 joon-ho kil. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var model: Model?
    var currentPhotoIndex = [Int]()
    
    let backButton: UIButton = {
        let backButton = UIButton()
        let backImage = UIImage(named: "wippy_common_back_btn")
        backButton.setImage(backImage, for: .normal)
        
        return backButton
    }()
    let profileLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.text = "프로필"
        profileLabel.font = UIFont(name: "NanumBarunGothicBold", size: 20)
        
        return profileLabel
    }()
    let reportButton: UIButton = {
        let backButton = UIButton()
        let backImage = UIImage(named: "wippy_voice_talk_report_icon")
        backButton.setImage(backImage, for: .normal)
        
        return backButton
    }()
    let profilePhoto = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let badButton: UIButton = {
        let badButton = UIButton()
        let badImage = UIImage(named: "wippy_recommend_profile_bad_btn_off")
        badButton.setImage(badImage, for: .normal)
        
        return badButton
    }()
    let goodButton: UIButton = {
        let goodButton = UIButton()
        let image = UIImage(named: "wippy_recommend_profile_good_btn_off")
        goodButton.setImage(image, for: .normal)
        
        return goodButton
    }()
    let progressImages: [UIImageView] = {
        let offImage = UIImage(named: "wippy_recommend_profile_gallery_page_nav_off")
        let onImage = UIImage(named: "wippy_recommend_profile_gallery_page_nav_on")
        let array = [0, 1, 2]
        let progressImages = array.map { (index) -> UIImageView in
            if index == 0 {
                return UIImageView(image: onImage)
            }
            return UIImageView(image: offImage)
        }
        return progressImages
    }()
    let infoTableView = UITableView(frame: CGRect.zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewArrangement()
        collectionViewSetup()
        tableViewSetup()
        
        let callBack = { (_ model: Model) in
            self.model = model
            DispatchQueue.main.sync {
                self.profilePhoto.reloadData()
                self.infoTableView.reloadData()
            }
            return
        }
        
        JSONReceiver.getJson(callBack: callBack)
    }

    func viewArrangement() {
        self.view.addSubview(backButton)
        self.view.addSubview(profileLabel)
        self.view.addSubview(reportButton)
        self.view.addSubview(profilePhoto)
        self.view.addSubview(infoTableView)
        self.view.addSubview(badButton)
        self.view.addSubview(goodButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            make.leading.equalTo(backButton.snp.trailing).offset(8)
            make.width.equalTo(57)
            make.height.equalTo(23)
        }
        
        reportButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(23)
            make.height.equalTo(23)
        }
    
        profilePhoto.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(22)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.width)
        }
        
        
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(profilePhoto.snp.bottom).offset(9)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        badButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(view.snp.centerX).offset(-5)
            make.height.equalTo(badButton.snp.width).multipliedBy(74.0/182.0)
        }
        
        goodButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-8)
            make.leading.equalTo(view.snp.centerX).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(badButton.snp.width).multipliedBy(74.0/182.0)
        }
        
        for (index, image) in progressImages.enumerated() {
            self.view.addSubview(image)
            image.snp.makeConstraints { make in
                make.bottom.equalTo(profilePhoto.snp.bottom).offset(-15)
                make.height.equalTo(10)
                make.width.equalTo(10)
                make.leading.equalTo(profilePhoto.snp.centerX).offset(-22+index*17)
            }
        }
    }
    
    func collectionViewSetup() {
        profilePhoto.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.ID)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        profilePhoto.collectionViewLayout = layout
        profilePhoto.showsHorizontalScrollIndicator = false
        profilePhoto.isPagingEnabled = true
        profilePhoto.delegate = self
        profilePhoto.dataSource = self
    }
    
    func tableViewSetup() {
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.ID)
        infoTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.ID)
        infoTableView.allowsSelection = false
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.profileImages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.ID, for: indexPath) as! PhotoCollectionViewCell
        
        guard let imageURL = model?.profileImages[indexPath.row] else { return cell }
        guard let url = URL(string: imageURL) else { return cell }
        guard let data = try? Data(contentsOf: url) else { return cell }
        if let image = UIImage(data: data) {
            cell.profileImageView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentPhotoIndex.append(indexPath.row)
        showPhotoIndex()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentPhotoIndex.removeAll { (number) -> Bool in
            number == indexPath.row
        }
        showPhotoIndex()
    }
    
    func showPhotoIndex() {
        for index in 0...2 {
            if currentPhotoIndex.contains(index) {
                progressImages[index].image = UIImage(named: "wippy_recommend_profile_gallery_page_nav_on")
            } else {
                progressImages[index].image = UIImage(named: "wippy_recommend_profile_gallery_page_nav_off")
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.ID, for: indexPath) as! MainTableViewCell
            cell.putInfo(model: model)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.ID, for: indexPath) as! DetailTableViewCell
            cell.putInfo(model: model, indexPath: indexPath)
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(100)
        }
        return CGFloat(158)
    }
}
