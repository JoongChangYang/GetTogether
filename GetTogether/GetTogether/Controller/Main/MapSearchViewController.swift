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
    
//    private var annotations: [String : (view: UIView, constrain: NSLayoutConstraint)] = [:]
    let placeInfoView = PlaceInfoView()
    let mapSearchView = MapSearchView()
    private let searchBar = UISearchController()
    let api = Api(apiProtocol: .http, apiUrl: .addPromise, port: 80)
    private let className = "MapSearchViewController"
    weak var delegate: MapSearchViewControllerDelegate?
    private var coordinate: Coordinate?
    private var addressName: String?
    var model = MapSearchModel()
    private var makePromiseCase = MakePromiseCase.defult
    
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
        guard let documents = json["documents"] as? [[String: Any?]] else { return print(#function, #line, "Error")}
        
        guard let places = documents as? [[String: String]] else { return print( #function , #line, "Error")}
        
        var tempList: [Place] = []
        
        for place in places {
            guard
                let optionalX = place["x"],
                let optionalY = place["y"],
                let x = Double(optionalX),
                let y = Double(optionalY)
            else {
                print( #function , #line, "Error")
                continue
            }
            
            let coordinate = Coordinate(latitude: y, longitude: x)
            let placeName = place["place_name"]
            let roadAddress = place["road_address_name"]
            let addressName = place["address_name"]
            let placeUrl = place["http://place.map.kakao.com/26338954"]
            
            let tempPlace = Place(
                coordinate: coordinate,
                placeName: placeName,
                roadAddress: roadAddress,
                addressName: addressName,
                placeUrl: placeUrl)
            
            tempList.append(tempPlace)
        }
        model.placeList = tempList
        addAnotationsAndSetRegion()
        
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.searchBar.delegate = self
        
    }
    
    private func setupUI() {
        let margin: CGFloat = 40
        let guide = view.safeAreaLayoutGuide
        view.addSubview(mapSearchView)
        view.addSubview(placeInfoView)
        mapSearchView.layout.top().leading().trailing().bottom()
        mapSearchView.mapView.delegate = self
        
        placeInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        placeInfoView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
        placeInfoView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        placeInfoView.widthAnchor.constraint(equalTo: guide.widthAnchor, constant: -margin).isActive = true
        placeInfoView.heightAnchor.constraint(equalTo: guide.widthAnchor, constant: -margin).isActive = true
        
        
        placeInfoView.delegate = self
        
        
    }
    
    
    private func addAnotationsAndSetRegion() {
        let longitude = model.placeList.reduce(0.0, {
            $0 + $1.coordinate.longitude
        }) / Double(model.placeList.count)
        
        let latitude = model.placeList.reduce(0.0, {
            $0 + $1.coordinate.latitude
        }) / Double(model.placeList.count)
        
        let latitudes = model.placeList.sorted(by: { (first, second) in
            first.coordinate.latitude > second.coordinate.latitude
        }).map({ $0.coordinate.latitude })
        
        let longitudes = model.placeList.sorted(by: { (first, second) in
            first.coordinate.longitude > second.coordinate.longitude
        }).map({ $0.coordinate.longitude })
        
        guard
            let latitudeFirst = latitudes.first,
            let latitudeLast = latitudes.last,
            let longitudeFirst = longitudes.first,
            let longitueLast = longitudes.last
            else {
                return
        }
        
        let latitudeSize = latitudeFirst - latitudeLast
        let longitudeSize = longitudeFirst - longitueLast
//        print(latitudeSize, longitudeSize)
        
        let center = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: latitudeSize, longitudeDelta: longitudeSize)
        let region = MKCoordinateRegion(center: center, span: span)
        mapSearchView.mapView.setRegion(region, animated: true)
        mapSearchView.mapView.removeAnnotations(mapSearchView.mapView.annotations)
//        annotations.removeAll()
        model.placeList.forEach({
            
            if let roadAdress = $0.roadAddress {
                
                let coordinate = CLLocationCoordinate2D(
                    latitude: $0.coordinate.latitude,
                    longitude: $0.coordinate.longitude)
                let annotation = MKPointAnnotation()
                annotation.title = $0.placeName
                annotation.subtitle = roadAdress
                annotation.coordinate = coordinate
                mapSearchView.mapView.addAnnotation(annotation)
            }
            
        })
        
        
        
        
    }
    
    
    
    

}

extension MapSearchViewController: PlaceInfoViewDelegate {
    func close() {
        UIView.animate(withDuration: 0.2, animations: {
            self.placeInfoView.transform = .init(scaleX: 0, y: 0)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.placeInfoView.isHidden = true
            
        })
        self.mapSearchView.mapView.selectedAnnotations.removeAll()
        
    }
    
    
    func makePromise() {
        guard
            let placeTitle = model.placeTitle,
            let addressName = model.addressName,
            let coordinate = model.coordinate
            else { return }
        
        let model = MakePromiseModel(placeTitle: placeTitle, coordinate: coordinate, addressName: addressName)
        
        let makePromissVC = MakePromiseViewController(model: model, makePromiseCase: makePromiseCase)
        navigationController?.pushViewController(makePromissVC, animated: true)
        
    }
    
    
}


extension MapSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        api.kakaoSearch(queryType: .keyword, data: [ "query": query ], notificationName: className + NotificationName.searchKakao.rawValue)
    }
    
    
    // annotation 선택시 alert창이 뜨고 확인을 누르면 이전 컨트롤러에 좌표와 주소 전달
    private func disPlayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let addressName = self.addressName, let coordinate = self.coordinate else { return }
            self.delegate?.didTapOkButton(coordinate: coordinate, addressName: addressName)
            self.navigationController?.popViewController(animated: true)
        })
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancleAction)
        present(alertController, animated: true)
    }
    
    
    
}


extension MapSearchViewController: UITableViewDelegate {
    
}


extension MapSearchViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if makePromiseCase == .defult{
            guard
                 let annotation = view.annotation,
                 let optionalSubTitle = annotation.subtitle,
                 let subTitle = optionalSubTitle
                 else { return }
             
             guard let index = model.placeList.firstIndex(where: {
                 $0.roadAddress == subTitle
             }) else { return }
             
             let place = model.placeList[index]
            
             model.placeTitle = place.placeName
             model.addressName = place.roadAddress
             model.coordinate = place.coordinate
             
             placeInfoView.contfigure(placeName: place.placeName, roadAddress: place.roadAddress, adddressName: place.addressName, placeUrl: place.placeUrl)
             
             placeInfoView.isHidden = false
             UIView.animate(withDuration: 0.2, animations: {
                 self.placeInfoView.transform = .identity
                 self.placeInfoView.layoutIfNeeded()
             })
             
        }
        
        
    }
    
    
    
    
    
    
    
}
