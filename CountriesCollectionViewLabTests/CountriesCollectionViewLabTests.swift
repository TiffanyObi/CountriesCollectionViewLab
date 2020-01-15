//
//  CountriesCollectionViewLabTests.swift
//  CountriesCollectionViewLabTests
//
//  Created by Tiffany Obi on 1/15/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import XCTest
import NetworkHelper
@testable import CountriesCollectionViewLab


class CountriesCollectionViewLabTests: XCTestCase {
    
    
    func testUrlStringForData() {
        let exp = XCTestExpectation(description: "search found")
        let elementEndpointURL = "https://restcountries.eu/rest/v2/name/united"
        let request = URLRequest(url: URL(string: elementEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
                
            case .success(let data):
                exp.fulfill()
                
                XCTAssertGreaterThan(data.count, 7_000, "data.count:\(data) should be greater that 71,000bytes .")
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }

    
    
    func testElementModel() {
        
        struct Country:Decodable {
            
            let name: String
            let region: String
        }
        
        
  let json = """
    [{
            "name": "United States Minor Outlying Islands",
            "topLevelDomain": [
                ".us"
            ],
            "alpha2Code": "UM",
            "alpha3Code": "UMI",
            "callingCodes": [
                ""
            ],
            "capital": "",
            "altSpellings": [
                "UM"
            ],
            "region": "Americas",
            "subregion": "Northern America",
            "population": 300,
            "latlng": [],
            "demonym": "American",
            "area": null,
            "gini": null,
            "timezones": [
                "UTC-11:00",
                "UTC-10:00",
                "UTC+12:00"
            ],
            "borders": [],
            "nativeName": "United States Minor Outlying Islands",
            "numericCode": "581",
            "currencies": [{
                "code": "USD",
                "name": "United States Dollar",
                "symbol": "$"
            }],
            "languages": [{
                "iso639_1": "en",
                "iso639_2": "eng",
                "name": "English",
                "nativeName": "English"
            }],
            "translations": {
                "de": "Kleinere Inselbesitzungen der Vereinigten Staaten",
                "es": "Islas Ultramarinas Menores de Estados Unidos",
                "fr": "Îles mineures éloignées des États-Unis",
                "ja": "合衆国領有小離島",
                "it": "Isole minori esterne degli Stati Uniti d'America",
                "br": "Ilhas Menores Distantes dos Estados Unidos",
                "pt": "Ilhas Menores Distantes dos Estados Unidos",
                "nl": "Kleine afgelegen eilanden van de Verenigde Staten",
                "hr": "Mali udaljeni otoci SAD-a",
                "fa": "جزایر کوچک حاشیه‌ای ایالات متحده آمریکا"
            },
            "flag": "https://restcountries.eu/data/umi.svg",
            "regionalBlocs": [],
            "cioc": ""
        },
        {
            "name": "United States Minor Outlying Islands",
            "topLevelDomain": [
                ".us"
            ],
            "alpha2Code": "UM",
            "alpha3Code": "UMI",
            "callingCodes": [
                ""
            ],
            "capital": "",
            "altSpellings": [
                "UM"
            ],
            "region": "Americas",
            "subregion": "Northern America",
            "population": 300,
            "latlng": [],
            "demonym": "American",
            "area": null,
            "gini": null,
            "timezones": [
                "UTC-11:00",
                "UTC-10:00",
                "UTC+12:00"
            ],
            "borders": [],
            "nativeName": "United States Minor Outlying Islands",
            "numericCode": "581",
            "currencies": [{
                "code": "USD",
                "name": "United States Dollar",
                "symbol": "$"
            }],
            "languages": [{
                "iso639_1": "en",
                "iso639_2": "eng",
                "name": "English",
                "nativeName": "English"
            }],
            "translations": {
                "de": "Kleinere Inselbesitzungen der Vereinigten Staaten",
                "es": "Islas Ultramarinas Menores de Estados Unidos",
                "fr": "Îles mineures éloignées des États-Unis",
                "ja": "合衆国領有小離島",
                "it": "Isole minori esterne degli Stati Uniti d'America",
                "br": "Ilhas Menores Distantes dos Estados Unidos",
                "pt": "Ilhas Menores Distantes dos Estados Unidos",
                "nl": "Kleine afgelegen eilanden van de Verenigde Staten",
                "hr": "Mali udaljeni otoci SAD-a",
                "fa": "جزایر کوچک حاشیه‌ای ایالات متحده آمریکا"
            },
            "flag": "https://restcountries.eu/data/umi.svg",
            "regionalBlocs": [],
            "cioc": ""
        }
    ]
    """.data(using: .utf8)!
    
    
    let expectedcount = "United States Minor Outlying Islands"
    
    let countries = try! JSONDecoder().decode([Country].self, from: json)
        
        XCTAssertEqual(countries.first?.name, expectedcount, "both should equal \"United States Minor Outlying Islands\"")
    
}
}
