//
//  CountryCell.swift
//  CountriesCollectionViewLab
//
//  Created by Tiffany Obi on 1/15/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import ImageKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var countryCapitalLabel: UILabel!
    
    @IBOutlet weak var countryPopulationLabel: UILabel!
    
    var country = Country?.self
    
    
    
   
     func configureCell(for country: Country) {
        
        self.contentView.layer.borderWidth = 5
        let photoString = "https://www.countryflags.io/\(country.alpha2Code.lowercased())/shiny/64.png"
      
        flagImageView.getImage(with: photoString) {[weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.flagImageView.image = UIImage(named:"country")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImageView.image = image
                }
            }
        }
        
        
        DispatchQueue.main.async { 
    
            self.countryNameLabel.text = country.name
        
            self.countryCapitalLabel.text = country.capital
        
            self.countryPopulationLabel.text = "Population: \(country.population)"
        
    }
    }
    
}
