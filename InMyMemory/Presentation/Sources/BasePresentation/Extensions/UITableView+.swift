//
//  UITableView+.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

public extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeue<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? T else {
            fatalError("\(cell)을 등록하지 않았습니다.")
        }
        return cell
    }
    
}
