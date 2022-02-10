//
//  CategoryViewController.swift
//  Money Manager
//
//  Created by Thong Doan on 27/10/2021.
//

import UIKit
import RealmSwift
import AnyChartiOS
import Format
class CategoryViewController: UIViewController {
    
    @IBOutlet weak var lbTotalExpenses: UILabel!
    

    
    
    let realm = try! Realm()
//    let arrCategory = ["Category 1","Category 2","Category 3","Category 4"]
    var categories: Results<Category>?
    var arr:[String] = []
    var totalItemPrice = 0
    var totalExpense = 0
    var selectedCategory = Category()
//    var item: Results<Item>?
    @IBOutlet weak var tbView: UITableView!
    
    @IBOutlet weak var chartView: AnyChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for i in item! {
//            print(i.princeItem)
//        }
        load()
        loadChart()
//        loadCate()
        tbView.delegate = self
        tbView.dataSource = self
        DispatchQueue.main.async { [self] in
            lbTotalExpenses.text = "\(convertNumToCurentcy(num: totalExpense))"
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        var valueInputNewCategory = UITextField()
        let alert = UIAlertController(title: "ADD CATEGORY", message: "Add a new category", preferredStyle: .alert)
        let actionSave = UIAlertAction(title: "Save", style: .default) { [self] _ in
            let newCategory = Category()
            newCategory.name = valueInputNewCategory.text!
            save(object: newCategory)
            
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alert.addTextField { textField in
            textField.placeholder = "Input new category"
            valueInputNewCategory = textField
        }
        alert.addAction(actionSave)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    func save(object: Object) {
        do {
            try! realm.write({
                realm.add(object)
                tbView.reloadData()
            })
        }catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    func load() {
        do {
            categories = try! realm.objects(Category.self)
//            try! realm.objects(Category).sum
        }catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    //tạo chart
    func loadChart () {
        let chart = AnyChart.pie()
        var chartData: Array<DataEntry> = [
        ]
        for i in categories! {
            chartData.append(ValueDataEntry(x: i.name, value: i.totalPrice ))
        }
        chart.data(data: chartData)

//        chart.title(settings: "Fruits imported in 2015 (in kg)")

        chartView.setChart(chart: chart)
    }
    //convert Double to Currentcy
    func convertNumToCurentcy (num: Int) -> String{
        let frLocale = Locale(identifier: "es")
        let formattedNumber = num.format(Currency.VND, locale: frLocale) // 99,00 €
        print(formattedNumber)
        return formattedNumber
    }
    
}
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
//        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return categories?.count ?? 1
//    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        totalItemPrice = 0
        if let item = categories?[indexPath.row].items.sorted(byKeyPath: "princeItem", ascending: true) {
            for i in item {
                totalItemPrice += i.princeItem
            }
            totalExpense += totalItemPrice
        
            try! realm.write {
                categories?[indexPath.row].totalPrice = totalItemPrice
            }
        }
//        cell.viewColor.backgroundColor = categories?[indexPath.row].color!
//        cell.viewColor.backgroundColor = categories?[indexPath.row].color as! UIColor
//        cell.backgroundColor = UIColor(named: "darkIndigo")
        cell.lbNameCategory.text = categories?[indexPath.row].name
        cell.lbTotalCategory.text = convertNumToCurentcy(num: categories![indexPath.row].totalPrice)
//        cell.backgroundColor = UIColor.gray
//        cell.layer.cornerRadius = 15
        return cell
        
    }

}
class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var imaCategory: UIImageView!
    @IBOutlet weak var lbNameCategory: UILabel!
    @IBOutlet weak var lbTotalCategory: UILabel!
}

