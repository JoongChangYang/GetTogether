//
//  Api.swift
//  GetTogether
//
//  Created by 양중창 on 2020/02/02.
//  Copyright © 2020 didwndckd. All rights reserved.
//

import Foundation

enum ApiProtocol: String {
    case http = "http://"
}

enum ApiUrl: String {
    case signUp = "/SignUp.php"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum QueryType: String {
    case point = "/v2/local/geo/coord2address.json?"
    case address = "v2/local/search/address.json?"
    case keyword = "/v2/local/search/keyword.json?"
}


struct Api {
    let apiProtocol: ApiProtocol
    let ip = "192.168.0.103"
    let dir = "/GetTogether"
    let apiSocket: String
    let apiUrl: ApiUrl
    
    init(apiProtocol: ApiProtocol, apiUrl: ApiUrl, apiSocket: String) {
        self.apiProtocol = apiProtocol
        self.apiUrl = apiUrl
        self.apiSocket = apiSocket
    }
    
    mutating func request (method: HttpMethod, notificationName: NotificationName, data: [String: String] ) {
        
        if method == .get {
            requestOfGet(data: data, notificationName: notificationName.rawValue)
        }else {
            requestOfPost(data: data, notificationName: notificationName.rawValue)
        }
        
    }
    
    private func requestOfGet(data: [String: String], notificationName: String) {
        
        var body = data.reduce("?", { $0 + $1.key + "=" + $1.value + "&"})
        body.removeLast()
        
        //최종 Get 데이터 포함한 urlString
        let urlString = apiProtocol.rawValue + ip + apiSocket + dir + apiUrl.rawValue + body
//        debugPrint(urlString)
        
        //한글 url때문에 addingPercentEncoding 해줘야함
        guard let encodString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else { return print(#function, "\n urlEncodingError") } // 인코딩 실패시 예외 처리
        
        // 인코딩한 url을 URL타입의 객체로 변환
        guard let url = URL(string: encodString) else { return print(#function, "\n urlError")}
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(
            with: request,
            completionHandler: {(data, response, error) in
                
                guard error == nil && data != nil else { // 에러 또는 데이터가 들어오지 않았을 경우 예외처리
                    if let e = error {
                        print(e.localizedDescription)
                    }
                    return
                }
                
                // 이건 아직 뭔지 모르겠다
                if let _ = response as? HTTPURLResponse {
                    //                    print(#function, "\n 리스폰스: \(response.allHeaderFields)")
                    //                    print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
                    
                }
                
                // 들어온 데이터를 가공해서 notification을 날려준다
                guard let data = data else { return print(#function, "Data is nil")}
                guard let strData = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    else { return print(#function, "data Decoding Fail")}
                
                DispatchQueue.main.async {
                    print(strData)
                    let userInfo: [AnyHashable: Any] = [notificationName: strData]
                    NotificationCenter.default.post(
                        name: NSNotification.Name(notificationName),
                        object: nil,
                        userInfo: userInfo)
                }
        })
        
        task.resume()
    }
    
    
    
    
    private func requestOfPost(data: [String: String], notificationName: String) {
        
//        guard let jsonData = try? JSONEncoder().encode(data)
//            else { return print(#function, "json encodeFail")}
//
//        guard let bodyData = String(data: jsonData, encoding: .utf8)
//            else { return print(#function, "make bodyData Fail")}
        
        
        
        var body = data.reduce("", { $0 + $1.key + "=" + $1.value + "&"})
        body.removeLast()
        
        let paramData = body.data(using: .utf8)
        print(body)
        
        let urlString = apiProtocol.rawValue + ip + apiSocket + dir + apiUrl.rawValue
        
        guard let encodString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else { return print(#function, "\n urlEncodingError") }
        guard let url = URL(string: encodString) else { return print(#function, "\n urlError")}
        
        var request = URLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        
        request.setValue(String(paramData!.count), forHTTPHeaderField: "content-Length")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        let body = bodyData.data(using: String.Encoding.utf8, allowLossyConversion: false)
        request.httpBody = paramData
        
        let task = session.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                
                guard error == nil && data != nil else { // 에러 처리
                    if let e = error {
                        print(e.localizedDescription)
                    }
                    return
                }
                
                // 이건 아직 뭔지 모르겠다
//                if let response = response as? HTTPURLResponse {
//                    print(#function, "\n 리스폰스: \(response.allHeaderFields)")
//                    print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
//
//                }
                
                guard let data = data else { return print(#function, "Data is nil") }
                guard let strData = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    else { return print(#function, "data Decodding Fail") }
                
                DispatchQueue.main.async {
                    print(strData)
                    let userInfo = [notificationName: strData]
                    NotificationCenter.default.post(
                    name: NSNotification.Name(notificationName),
                    object: nil,
                    userInfo: userInfo)
                }
                
        })
        task.resume()
        
        
        
        
    }
    
  
//    // POST METHOD
//
//       func post(url: URL, body: NSMutableDictionary, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws {
//            let session: URLSession = URLSession.shared
//           var request: URLRequest = URLRequest(url: url)
//
//
//
//           request.httpMethod = "POST"
//
//           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//           request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//           request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//
//
//           session.dataTask(with: request, completionHandler: completionHandler).resume()
//
//       }
    
    
    
    func kakaoSearch(queryType: QueryType, data: [String: Any]) {
        
        
        let kakaoUrl = "https://dapi.kakao.com"
        let queryType = queryType.rawValue
        let key = "6dc9e4435c9d24dec5c9fe5e3da6948a"
        
    }
    
    func kakoSearchOfAddress() {
        
    }
    
    func kakaoSearchOfPoint() {
        
    }
    
    
}


