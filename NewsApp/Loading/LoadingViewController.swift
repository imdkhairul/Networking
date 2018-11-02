//
//  LoadingViewController.swift
//  LoadingController
//
//  Created by Khairul on 10/31/18.
//  Copyright © 2018 Khairul. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    let activityIndicatorView:UIActivityIndicatorView = UIActivityIndicatorView.init(style: .gray)
    
    init<A>(load:((Result<A>) -> ()) -> (),build: (A) -> UIViewController) {
        super.init(nibName: nil, bundle: nil)
        activityIndicatorView.startAnimating()
        load(){[weak self] result in
            self?.activityIndicatorView.stopAnimating()
            guard let value = result.value else {return}
            let viewcontroller = build(value)
            self?.add(content: viewcontroller)
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = CGPoint.init(x: view.bounds.width/2, y: view.bounds.height/2)
        // Do any additional setup after loading the view.
    }
    
    func add(content: UIViewController) {
        addChild(content)
        view.addSubview(content.view)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        content.didMove(toParent: self)
    }

}
