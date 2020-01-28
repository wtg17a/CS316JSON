//
//  DataGetter.swift
//  JSON Something
//
//  Created by William Gibbs on 1/28/20.
//  Copyright © 2020 William Gibbs. All rights reserved.
//

import UIKit

class DataGetter: NSObject
{
    let JSONURL = "https://api.myjson.com/bins/810tq"
    
    var dataArray = ["It's a little drafty in here."]
    
    func getData(completion: @escaping (_ success: Bool) -> ())
    {
        var success = true
        
        let actualUrl = URL(string: JSONURL)
        
        let task = URLSession.shared.dataTask(with: actualUrl!)
        {
            (data, response, error) in
            
            guard let _ = data, error == nil else
            {
                success = false
                return
            }
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
            {
                print(jsonObj.value(forKey: "characters")!)
                    
                if let dragonArray = jsonObj.value(forKey: "characters") as? Array<String>
                {
                    self.dataArray = dragonArray
                }
            }
            
            completion(success)
        }
        
        task.resume()
    }
}
