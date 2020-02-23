//
//  JsonReceiver.swift
//  nrise
//
//  Created by joon-ho kil on 2019/12/31.
//  Copyright © 2019 joon-ho kil. All rights reserved.
//

import Foundation

struct JSONReceiver {
    static func getJson(callBack: @escaping (Model)->()) -> Model? {
        var model: Model? = nil
        
        guard let url = URL(string: "https://static.wippy.io/r/app_bind.json") else {
            return nil
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("load data failed")
                return
            }

            let decoder: JSONDecoder = JSONDecoder()
            do {
                model =  try decoder.decode(Model.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            
            if let model = model {
                callBack(model)
            }
        }
        
        task.resume()

        return model
    }
}
