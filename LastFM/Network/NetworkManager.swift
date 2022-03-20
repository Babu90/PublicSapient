//
//  NetworkManager.swift
//  LastFM
//
//  Created by Babu on 19/03/2021.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    private let sessionManager:Session
    //Dependency injection. useful while mocking the data when we write Unit tests in future
    init(manager: Session = Session.default){
        self.sessionManager = manager
    }
    
    func fetchData(url: URL, completionHandler : @escaping (_ responseData:Data)->())
    {
        self.sessionManager.request(url).responseData { response in
            do {
                if let json = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [Any] {
                    print(json)
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            completionHandler(response.data ?? Data())
        }
    }
}
