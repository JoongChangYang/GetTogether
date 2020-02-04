//
//  MapSearchViewController.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/03.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import UIKit
import MapKit

protocol MapSearchViewControllerDelegate: class {
    func didTapOkButton(coordinate: Coordinate, addressName: String)
}


class MapSearchViewController: UIViewController {
    
    private let mapSearchView = MapSearchView()
    private let searchBar = UISearchController()
    private let api = Api(apiProtocol: .http, apiUrl: .signUp, port: 80)
    private let className = "MapSearchViewController"
    private let queryType: QueryType
    weak var delegate: MapSearchViewControllerDelegate?
    private var coordinate: Coordinate?
    private var addressName: String?
    
    
    
    init(queryType: QueryType) {
        self.queryType = queryType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setupUI()
        addNotificationObservers()
        
    }
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getSearchValue(_:)),
            name: NSNotification.Name(className + NotificationName.searchKakao.rawValue),
            object: nil)
    }
    
    @objc func getSearchValue(_ notification: Notification) {
        guard let json = notification.userInfo?[className + NotificationName.searchKakao.rawValue] as? [String: Any] else { return }
//        dump(json["documents"])
        guard let documents = json["documents"] as? [[String: Any?]] else { return print(#function, #line, "Error")}
        guard let document = documents.first else { return print( #function , #line, "Error")}
        guard let roadAddress = document["road_address"] as? [String: Any?] else { return print( #function , #line, "Error")}
        guard
        let addressName = roadAddress["address_name"] as? String,
        let x = roadAddress["x"] as? String,
        let y = roadAddress["y"] as? String
            else { return print( #function , #line, "Error") }
        
        guard let latitude = Double(y), let longitude = Double(x) else { return }
        let coordinate = Coordinate(latitude: latitude, longitude: longitude)
        self.addressName = addressName
        self.coordinate = coordinate
        
        mapSearchView.addAnnotation(
            addressName: addressName,
            coordinate: coordinate)
        
        
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.searchController = searchBar
        searchBar.searchBar.delegate = self
        
    }
    
    private func setupUI() {
        view.addSubview(mapSearchView)
        mapSearchView.layout.top().leading().trailing().bottom()
        mapSearchView.mapView.delegate = self
    }

}


extension MapSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        api.kakaoSearch(queryType: queryType, data: [ "query": query ], notificationName: className + NotificationName.searchKakao.rawValue)
    }
    
    private func disPlayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let addressName = self.addressName, let coordinate = self.coordinate else { return }
            self.delegate?.didTapOkButton(coordinate: coordinate, addressName: addressName)
            self.dismiss(animated: true)
        })
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancleAction)
        present(alertController, animated: true)
    }
    
    
    
}




extension MapSearchViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        disPlayAlert(title: "현재 주소로 등록 하시겠습니까?", message: "주소: \(addressName)")
    }
    
    
    
}
