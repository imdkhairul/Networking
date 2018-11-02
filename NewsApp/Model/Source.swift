//
//  Source.swift
//  NewsApp
//
//  Created by Khairul Islam on 10/23/18.
//  Copyright © 2018 Khairul Islam. All rights reserved.
//

import UIKit

struct Source
{
    var id:String = ""
    var name:String = ""
}

extension Source
{
    init?(dictionary:JSONdictionary) {
        if let id = dictionary["id"] as? String
        {
            self.id = id
        }
        if let name = dictionary["name"] as? String
        {
            self.name = name
        }
    }
}
