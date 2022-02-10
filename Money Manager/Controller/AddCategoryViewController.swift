//
//  AddCategoryViewController.swift
//  Money Manager
//
//  Created by Thong Doan on 08/11/2021.
//

import UIKit
import IGColorPicker
import RealmSwift
class AddCategoryViewController: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {
    let realm = try! Realm()
    @IBOutlet weak var colorPickerView: ColorPickerView!
    @IBOutlet weak var textFieldNewNameCateGory: UITextField!
    var colorCategory = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        selectedColorView.layer.cornerRadius = selectedColorView.frame.width/2
//
        // Setup colorPickerView
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.style = .circle
        colorPickerView.selectionStyle = .check
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.preselectedIndex = colorPickerView.colors.indices.first
        
//        selectedColorView.backgroundColor = colorPickerView.colors.first
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSavePressed(_ sender: UIButton) {
        let newCategory = Category()
        newCategory.name = textFieldNewNameCateGory.text!
        newCategory.color = colorCategory
        save(object: newCategory)
        
    }
    func save(object: Object) {
        do {
            try! realm.write({
                realm.add(object)
            })
        }catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    // MARK: - ColorPickerViewDelegate
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedColorView.backgroundColor = colorPickerView.colors[indexPath.item]
        colorCategory = "\(colorPickerView.colors[indexPath.item] as! UIColor)"
        print(colorPickerView.colors[indexPath.item].accessibilityName)
    }
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension AddCategoryViewController :UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return color.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorPickerCell", for: indexPath)
//        cell.backgroundColor = color[indexPath.row]
//        cell.layer.cornerRadius = 30
//        collectionView.layer.cornerRadius = 20
//
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(color[indexPath.row].accessibilityName)
//    }
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return user
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! HomeCell
////
////        let item = users[indexPath.row]
////        cell.nameLabel.text = item.name
////        cell.avatarimageView.image = UIImage(named: item.avatar)
////        cell.layer.cornerRadius = 30
////        cell.backgroundColor = .red
////        return cell
////    }
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        print(indexPath.row)
////    }
//
//}

class ColorPickerViewCell: UICollectionViewCell {
    @IBOutlet weak var btnColor: UIButton!
    
}
