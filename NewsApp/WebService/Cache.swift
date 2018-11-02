//
//  Cache.swift
//  NewsApp
//
//  Created by Khairul Islam on 10/26/18.
//  Copyright © 2018 Khairul Islam. All rights reserved.
//

import UIKit

struct FileStorage {
    let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    subscript(key:String) -> Data?
    {
        get{
            let url = baseURL.appendingPathComponent(key)
            return try? Data(contentsOf: url)
        }
        set{
            let url = baseURL.appendingPathComponent(key)
            _ = try? newValue?.write(to: url)
        }
    }
}

final class Cache {
    
    var storage = FileStorage()
    
    func load<A>(_ resource:Resource<A>) -> A?{
        guard case .get = resource.method else {return nil}
        let data = storage[resource.cacheKey]
        return data.flatMap(resource.parse)
    }
    
    func save<A>(_ data:Data,for resource:Resource<A>)
    {
        guard case .get = resource.method else {return}
        storage[resource.cacheKey] = data
    }
}
