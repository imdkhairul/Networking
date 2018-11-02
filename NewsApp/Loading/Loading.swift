//
//  Loading.swift
//  LoadingController
//
//  Created by Khairul on 10/31/18.
//  Copyright © 2018 Khairul. All rights reserved.
//

import UIKit

let sharedWebService = CachedWebService(WebService())

protocol Loading
{
    associatedtype ResourceType
    var activityIndicator:UIActivityIndicatorView {get}
    func configure(value:ResourceType)
}

extension Loading where Self:UIViewController
{
    func load(resource:Resource<ResourceType>)
    {
        activityIndicator.startAnimating()
        sharedWebService.load(resource) { [weak self] result in
            self?.activityIndicator.stopAnimating()
            guard let value = result.value else {return}
            self?.configure(value: value!)
        }
    }
}
