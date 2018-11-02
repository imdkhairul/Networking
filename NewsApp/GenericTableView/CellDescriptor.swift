//
//  CellDescriptor.swift
//  GenericTableView
//
//  Created by Khairul Islam on 10/29/18.
//  Copyright © 2018 Khairul Islam. All rights reserved.
//

import UIKit

struct CellDescriptor
{
    let cellClass:UITableViewCell.Type
    let reuseIdentifier:String
    let cellNibName:String
    let configure:(UITableViewCell) -> ()
    
    init<Cell:UITableViewCell>(reuseIdentifier:String,nibName:String,configure:@escaping (Cell) -> ())
    {
        self.cellClass = Cell.self
        self.reuseIdentifier = reuseIdentifier
        self.cellNibName = nibName
        self.configure = { cell in
            configure(cell as! Cell)
        }
    }
}
