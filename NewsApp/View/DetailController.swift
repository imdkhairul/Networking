//
//  DetailController.swift
//  LoadingController
//
//  Created by Khairul on 10/31/18.
//  Copyright © 2018 Khairul. All rights reserved.
//

import UIKit

class DetailController: GenericTableVIewController<Article>,Loading
{
    let titleLabel = UILabel()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .gray)
    
    init(articles:[Article])
    {
        super.init()
        configure(value: articles)
    }

    convenience init(resource:Resource<[Article]>)
    {
        self.init(articles: [])
        load(resource: resource)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(value: [Article])
    {
        self.items = value
        self.cellDescriptor = {$0.cellDescriptor}
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view. view.backgroundColor = .whiteColor()
        view.backgroundColor = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        //titleLabel.constrainEdges(toMarginOf: view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
