//
//  CachedWebService.swift
//  NewsApp
//
//  Created by Khairul Islam on 10/26/18.
//  Copyright © 2018 Khairul Islam. All rights reserved.
//

import UIKit

final class CachedWebService {

    let cache = Cache()
    var webservice = WebService()
    
    init(_ webservice: WebService) {
        self.webservice = webservice
    }
    
    func load<A>(_ resource:Resource<A>,update:@escaping (Result<A?>) ->())
    {
        if let result = cache.load(resource)
        {
            mainQueue {
                update(.success(result))
            }
        }

        let dataResource = Resource<Data>(url: resource.url, parse: {$0}, method: resource.method)
        webservice.load(resource: dataResource, completion:  { (result) in
            switch result
            {
            case let .failure(error):
                update(.failure(error))
            case let .success(data):
                if let data = data {
                    self.cache.save(data, for: resource)
                    let result = resource.parse(data)
                    mainQueue {
                        update(.success(result))
                    }
                }
            }
        })
        
    }
}
