//
//  CountryAPIClient.swift
//  CountriesCollectionViewLab
//
//  Created by Tiffany Obi on 1/15/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation
import  NetworkHelper

struct CountryAPIClient {
    
    static func getCountries(completion: @escaping (Result<[Country],AppError>) -> ()) {
        
        
        let endpointURLString = "https://restcountries.eu/rest/v2/name/united"
        
        guard let url = URL(string: endpointURLString) else {
    completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
        
            switch result {
            case .failure(let appError):
                
                completion(.failure(.networkClientError(appError)))
                

            case .success(let countries):
                
                do {
                    
                    let countrysData = try JSONDecoder().decode([Country].self, from: countries)
                    
                    completion(.success(countrysData))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        
    }
}
