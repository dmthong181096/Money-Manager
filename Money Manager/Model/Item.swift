//
//  Item.swift
//  Money Manager
//
//  Created by Thong Doan on 28/10/2021.
//

import Foundation
import RealmSwift
class Item : Object {
    @objc dynamic var nameItem:String = ""
    @objc dynamic var dateCreated: String = ""
    @objc dynamic var princeItem:Int = 0
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
