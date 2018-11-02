//
//  Resource.swift
//  NewsApp
//
//  Created by Khairul Islam on 10/21/18.
//  Copyright © 2018 Khairul Islam. All rights reserved.
//

import UIKit

let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=2f4e37a208fd45878bd3b84cea11ca7a"

enum HttpMethod<Body>
{
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

extension HttpMethod
{
    func map<B>(f:(Body) -> B) ->HttpMethod<B>
    {
        switch self {
        case .get:
            return .get
        case .post(let body):
            return .post(f(body))
        }
    }
}

struct Resource<A>
{
    let url:URL
    let method:HttpMethod<Data>
    let parse:(Data) -> A?
    
    public init(url: URL, parse: @escaping (Data) -> A?, method: HttpMethod<Data> = .get) {
        self.url = url
        self.parse = parse
        self.method = method
    }
}

extension Resource
{
    var cacheKey:String{
        return "cache"+String(url.hashValue) // TODO use sha1
    }
}

extension Resource
{
    public init(url: URL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = .get
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            return json.flatMap(parseJSON)
        }
    }
    
    init(url:URL,method:HttpMethod<Any> = .get,parseJSON:@escaping (Any) -> A?) {
        self.url = url
        self.method = method.map{ json in
            return try! JSONSerialization.data(withJSONObject: json, options: [])
        }
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}

