//
//  APIManager.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 09/11/2021.
//

import Foundation
import SystemConfiguration

import UIKit
import Network
import WebKit

class APIManager {
    let baseURL = "https://raw.githubusercontent.com/beduExpert/Swift-Proyecto/main/API/db.json"
    
    static let shared = APIManager()
   
    
    func getMusic(completion: @escaping ([Track]?, Error?) -> ()) {
        print(#function)
        let url : String = baseURL
        let request : NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string:  url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if error != nil {
                completion(nil, error!)
                
            }
            else {
                if let data = data {
                 do{
                    let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [ String: Any ]
                    let songs = dict["songs"] as! [[String:Any]]
                    let songsData = try JSONSerialization.data(withJSONObject: songs, options: .fragmentsAllowed)
                    let result = try JSONDecoder().decode([Track].self, from: songsData)
                    
                    completion (result, nil)
                     print(result)
                }
                catch {
                    print(String(describing: error))
                }
            }
        }
    }
    task.resume()
    
    }
    
    func checkConnectivity() -> Int {
        //Internet Status = 1 -> hay internet
        //Internet Status = 0 -> hay internet de datos moviles
        //Internet Status = -1 -> no hay internet
        var monitor:NWPathMonitor!
        monitor = NWPathMonitor()
        var internetStatus = 1
        monitor.pathUpdateHandler = { Path in
            
            if Path.status == .satisfied {
                if Path.isExpensive {internetStatus = 0}
            }
            else {
                internetStatus = -1
            }
        }
        return internetStatus
    }
}
