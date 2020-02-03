//
//  MapSearchViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/03.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit

class MapSearchViewController: UIViewController {
    
    let mapSearchView = MapSearchView()
    let searchBar = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setupUI()
        
    }
    
    
    private func setNavigation() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.searchController = searchBar
    }
    
    private func setupUI() {
        view.addSubview(mapSearchView)
        mapSearchView.layout.top().leading().trailing().bottom()
    }

}
