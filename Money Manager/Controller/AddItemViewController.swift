//
//  AddItemViewController.swift
//  Money Manager
//
//  Created by Thong Doan on 28/10/2021.
//

import UIKit
import iOSDropDown
import RealmSwift
class AddItemViewController: UIViewController {

    @IBOutlet weak var dropDownCategory: DropDown!
    @IBOutlet weak var addNameItem: UITextField!
    @IBOutlet weak var addPriceItem: UITextField!
    @IBOutlet weak var addDate: UIDatePicker!
    var categories: Results<Category>?
    var categoryName:[String] = []
    var selectedCategory = Category()
    let realm = try! Realm()
    var indexCategory = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        dropDownCategory.optionArray = categoryName
        //Its Id Values and its optional
//        dropDownCategory.optionIds = [1,23,54,22]

//        dropDownCategory.didSelect{ [self](selectedText , index ,id) in
//         print("Selected String: \(selectedText) \n index: \(index)")
//            indexCategory = index
//            }
        }
        
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if let currentCategory = categories?[indexCategory] {
            do {
                try! realm.write({// thêm dữ liệu vào realm
                    let newItem = Item()
                    newItem.nameItem = addNameItem.text!
                    newItem.princeItem = Int(addPriceItem.text!)!
            //        addDate.timeZone = TimeZone.init(identifier: "GMT+7")
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                    let dateString = dateFormatter.string(from: addDate.date)
                    newItem.dateCreated = dateString
                    currentCategory.items.append(newItem) //truy cấp thêm từ category chứ k phải item
                })
            }catch {
                print("Error: \(error.localizedDescription)")
            }
    
        }else{
            print("Lỗi \(selectedCategory)")
        }
    }
//    func save (object: Object) {
//        do {
//            try! realm.write({
//                realm.add(object)
//            })
//        }catch {
//            print("error: \(error.localizedDescription)")
//        }
//    }
    func loadCategory() {
        do {
            categories = try! realm.objects(Category.self)
            for category in categories! {
                categoryName.append(category.name)
            }
        }catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
