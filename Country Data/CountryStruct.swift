//
//  CountryStruct.swift
//  CountriesCollectionViewLab
//
//  Created by Tiffany Obi on 1/15/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let population: Double
    let alpha2Code: String
}
