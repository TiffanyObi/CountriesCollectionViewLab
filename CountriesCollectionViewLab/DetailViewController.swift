//
//  DetailViewController.swift
//  CountriesCollectionViewLab
//
//  Created by Tiffany Obi on 1/15/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var capitalNameLabel: UILabel!
    
    
    @IBOutlet weak var populationLabel: UILabel!
    
    
    var countryDetails: Country!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()    }
    
    func updateUI() {
        
        capitalNameLabel.text = countryDetails.capital
        
        countryNameLabel.text = countryDetails.name
        
        populationLabel.text = "Population: \(countryDetails.population)"
        
        let photoString = "https://www.countryflags.io/\(countryDetails.alpha2Code.lowercased())/shiny/64.png"
        
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
    

}
}
