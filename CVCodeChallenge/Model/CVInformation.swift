//
//  CVInformation.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 6/28/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

struct CVInformation: Codable {
    let name: String
    let surnames: String
    let age: Int
    let jobs: [Job]
    let skills: [Skill]
}

extension CVInformation {
    
    struct CodingData: Decodable {
        var info: Info
        var contact: Contact
        var education: [Education]
        var experience: [Job]
        var skills: [Skill]
        
        struct Info: Decodable {
            var name: String
            var surnames: String
            var age: Int
            var nationality: String
        }
    }
}

extension CVInformation.CodingData {
    
    var cvInformation: CVInformation {
        return CVInformation(name: info.name, surnames: info.surnames, age: info.age, jobs: experience, skills: skills)
    }
}
