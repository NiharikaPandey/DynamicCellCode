//
//  NetworkServiceCall.swift
//  DynamicCellCode
//
//  Created by Niharika on 31/07/19.
//  Copyright © 2019 Niharika. All rights reserved.
//

import Foundation

class NetworkServiceCall {
    
    var dataArray = [DataModel]()
    
    func getData(fromURL url: URL, completion: @escaping (_ data: [DataModel]?,_ title:String) -> Void) {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else{completion(nil,""); return}
            do {
                let isoString = NSString(data: data, encoding: String.Encoding.isoLatin1.rawValue)
                let utf8Data = isoString?.data(using: String.Encoding.utf8.rawValue)
                let json = try JSONSerialization.jsonObject(with: utf8Data!, options: .allowFragments) as! [String:Any]
                let title = json["title"] as! String
                let rows = json["rows"] as! [[String:Any]]
                self.dataArray.removeAll()
                for rowItem in rows {
                    let dataClass = DataModel()
                    dataClass.name = rowItem["title"] as? String
                    dataClass.details = rowItem["description"] as? String
                    dataClass.dataImage = rowItem["imageHref"] as? String
                    self.dataArray.append(dataClass)
                }
                completion(self.dataArray,title)
            }
            catch {
                print("error:")}
        }
        task.resume()
    }
    
    
}
