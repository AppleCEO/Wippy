//
//  Model.swift
//  nrise
//
//  Created by joon-ho kil on 2019/12/31.
//  Copyright © 2019 joon-ho kil. All rights reserved.
//

import Foundation

struct Model: Codable {
    let name: String
    let profileImages: [String]
    let age, location, distance, height: String
    let bloodType: String
    let isVerifyMobile: Bool
    let educationLevel, basicOccupation, resultDescription, religion: String
    let alcohol, smoke: String

    enum CodingKeys: String, CodingKey {
        case name
        case profileImages = "profile_images"
        case age, location, distance, height
        case bloodType = "blood_type"
        case isVerifyMobile = "is_verify_mobile"
        case educationLevel = "education_level"
        case basicOccupation = "basic_occupation"
        case resultDescription = "description"
        case religion, alcohol, smoke
    }
}
