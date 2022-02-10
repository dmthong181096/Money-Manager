//
//  ItemViewController.swift
//  Money Manager
//
//  Created by Thong Doan on 28/10/2021.
//

import UIKit
import RealmSwift
import iOSDropDown
import Format

class ItemViewController: UIViewController {
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var dropDownCategory: DropDown!
    var items: Results<Item>?
    
    var addValueItem = Item()
    var categories: Results<Category>?
    var categoryName:[String] = []
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
//        dropDownCategory.optionArray = categoryName
//        dropDownCategory.didSelect{ [self](selectedText , index ,id) in
//         print("Selected String: \(selectedText) \n index: \(index)")
////            indexCategory = index
//            }
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddItem", sender: self)
    }
    @IBAction func sortByCurentPressed(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        
        
        sortBy(indexSelected: sender.selectedSegmentIndex)
        
//
//        if sender.selectedSegmentIndex == 0{
//            print("Sort by calendar")
//            items = items?.sorted(byKeyPath: "dateCreated", ascending: true)
//
//        }else{
//            print("Sort by currentcy")
//            items = items?.sorted(byKeyPath: "princeItem", ascending: true)
//
//        }
        
    }
    @IBAction func sortByValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sortBy(ascending: false)
        }else {
            sortBy(ascending: true)
        }
        
    }
    func sortBy(indexSelected: Int = 0, ascending: Bool = false) {
        print(ascending)
        if indexSelected == 0{
            print("Sort by calendar")
            
            items = items?.sorted(byKeyPath: "dateCreated", ascending: ascending)
            
        }else{
            print("Sort by currentcy")
            items = items?.sorted(byKeyPath: "princeItem", ascending: ascending)
            
        }
        tbView.reloadData()
    }
//    func filterByCategory(value: String) {
//        items
//    }
    

    
}
extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
//        items!.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.lbNameItem.text = items?[indexPath.row].nameItem
        cell.lbDate.text = items![indexPath.row].dateCreated
        cell.lbPrice.text = convertNumToCurentcy(num: items![indexPath.row].princeItem) 
        return cell
    }
    func load() {
        do {
            items = try! realm.objects(Item.self)
            categories = try! realm.objects(Category.self)
            for category in categories! {
                categoryName.append(category.name)
            }
        }
    }
    
    func convertNumToCurentcy (num: Int) -> String{
        
        let frLocale = Locale(identifier: "es")
        let formattedNumber = num.format(Currency.VND, locale: frLocale) // 99,00 €
//        print(formattedNumber)
        
        return formattedNumber
    }
}
class ItemCell : UITableViewCell {
    
    @IBOutlet weak var lbNameItem: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbDate: UILabel!
}

extension ItemViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print(searchBar.text)
        items = items?.filter("nameItem CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "nameItem", ascending: true)
        tbView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 { //nếu kiểm tra bằng 0 thì hiện lại mảng cũ
                    load()
                    DispatchQueue.main.async {
                        searchBar.resignFirstResponder()// tắt bàn phím xuống
                    }
            tbView.reloadData()
                }
    }
}
