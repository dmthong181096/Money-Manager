//
//  Category.swift
//  Money Manager
//
//  Created by Thong Doan on 28/10/2021.
//

import Foundation
import RealmSwift
class Category : Object {
    @objc dynamic var name: String = ""
    @objc dynamic var totalPrice: Int = 0
    @objc dynamic var color: String = ""
    var items = List<Item>()
    
}
