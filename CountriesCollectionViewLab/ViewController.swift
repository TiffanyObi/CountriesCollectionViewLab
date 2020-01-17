//
//  ViewController.swift
//  CountriesCollectionViewLab
//
//  Created by Tiffany Obi on 1/15/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var countries = [Country](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            DispatchQueue.main.async {
              
                self.collectionView.reloadData()
        }
    }
}
    
    private func getCountries() {
        CountryAPIClient.getCountries { (result) in
            switch result {
            case .failure(let error):
                print("could not load countries - error: \(error)")
            case .success(let countriesData):
                self.countries = countriesData
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .cyan
        
        getCountries()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let index = collectionView.indexPathsForSelectedItems?.first else {
            fatalError("could not find view controller for segue")
        }
        
        detailVC.countryDetails = countries[index.row]
    }

}

extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("could not downcast to DogCell")
        }
        
        let countryInRow = countries[indexPath.row]
        
        countryCell.configureCell(for: countryInRow)
        
        return countryCell
    }
    
    
}


//here we are using UICollectionViewDelegateFlowLayout
extension ViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let interItemSpacing: CGFloat  = 10 //space between items
        let maxWidth = UIScreen.main.bounds.size.width //maximum screen width
        let numberOfItems: CGFloat = 1 // number of items per row
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth:CGFloat = (maxWidth - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // content edge insets = the padding or borders around cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension ViewController:UISearchBarDelegate {
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
       //dismiss keyboard
    searchBar.resignFirstResponder()

        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //dismiss the keyboard,
        
        
        guard !searchText.isEmpty else {
            //searchBar is empty hereb so we have to get back all lof the of the original.
            //usuing our loadData method.
           getCountries()
            return
        }

        
        
    }
    

}
