//
//  GenericTableVIewController.swift
//  GenericTableView
//
//  Created by Khairul Islam on 10/29/18.
//  Copyright © 2018 Khairul Islam. All rights reserved.
//

import UIKit

class GenericTableVIewController<Item>: UITableViewController {

    var items:[Item] = []
    var cellDescriptor:(Item) -> CellDescriptor = {_ in CellDescriptor(reuseIdentifier:"invalid", nibName: "invalid", configure: {_ in })}
    var didSelect:(Item) -> () = {_ in }
    var reuseIdentifiers:Set<String> = []
    
    init() {
        super.init(style: .plain)
    }
    
    convenience init(items:[Item],cellDescriptor:@escaping (Item) -> CellDescriptor) {
        self.init()
        self.cellDescriptor = cellDescriptor
        self.items = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cellDescriptor = self.cellDescriptor(item)
        
        if !reuseIdentifiers.contains(cellDescriptor.reuseIdentifier)
        {
            tableView.register(UINib(nibName: cellDescriptor.cellNibName, bundle: nil), forCellReuseIdentifier: cellDescriptor.reuseIdentifier)
            reuseIdentifiers.insert(cellDescriptor.reuseIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDescriptor.reuseIdentifier, for: indexPath)
        cellDescriptor.configure(cell)
        return cell
    }
}
