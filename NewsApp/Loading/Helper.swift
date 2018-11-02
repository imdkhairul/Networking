//
//  Helper.swift
//  NewsApp
//
//  Created by Khairul Islam on 11/1/18.
//  Copyright © 2018 Khairul Islam. All rights reserved.
//

import Foundation

public func mainQueue(block: @escaping () -> ()) {
    DispatchQueue.main.async {
        block()
    }
}
