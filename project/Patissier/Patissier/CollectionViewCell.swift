//
//  CollectionViewCell.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/9.
//

import UIKit

// let cell can Push
protocol PushDelegate: AnyObject {
    func pushNewView(_ cell: CollectionViewCell) -> Void
}


class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var iconHeart: UIImageView!
    @IBOutlet weak var picLabel: UILabel!
    @IBOutlet weak var iconPic: UIImageView!
    var productId: String = ""
    
    func cellInfo() {
        
        label1.layer.borderWidth = 0.3
        label1.layer.borderColor = UIColor.systemGray.cgColor
        label1.backgroundColor = .white
        
        iconLabel.layer.cornerRadius = 5
        iconLabel.layer.borderWidth = 0.5
        iconLabel.layer.borderColor = UIColor.systemGray2.cgColor
        iconLabel.backgroundColor = .white
        
        picLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        picLabel.layer.shadowColor = UIColor.black.cgColor
        picLabel.layer.shadowOpacity = 0.1
        picLabel.backgroundColor = .white
        
        iconHeart.image = iconHeart.image?.withRenderingMode(.alwaysTemplate)
        iconHeart.tintColor = .gray
        
        // origin
//        iconPic.image = iconPic.image?.withRenderingMode(.alwaysTemplate)
//        iconPic.tintColor = .gray
    }
    
    weak var delegate: PushDelegate? = nil
    
    @IBAction func tapToDetails(_ sender: Any) {
        
//        print("Tap details")
        self.delegate?.pushNewView(self)
        
    }
}
        
//        self.pushNewView()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let detailVC = storyboard.instantiateViewController(withIdentifier: "CellDetailTableViewController") as! CellDetailTableViewController
//        
//        // CollectionViewController.swift
//        if let navigationController: UINavigationController = self.navigationController {
//            navigationController.push(detailVC, animated: true)
//        } else {
//            print("No navigation found.")
//        }
        
   
        
//        let navVC1: UINavigationController = UINavigationController.init(rootViewController: detailVC)
//        let anotherVC = UICollectionViewController()
//        let navVC2 = UINavigationController(rootViewController: anotherVC)
//        detailVC.title = "Product"
//
//
//
////        navVC.pushViewController(anotherVC, animated: true)
//
//
//        if let n2 = anotherVC.navigationController {
//            print("A")
//            n2 === navVC2
//            let n1 = detailVC.navigationController
//            n1 === navVC1
//            n2.pushViewController(detailVC, animated: true)
//        } else {
//            print("B")
//        }
////        anotherVC.navigationController?.pushViewController(detailVC, animated: true)
//
//        anotherVC.navigationController?.pushViewController(detailVC, animated: true)
//
//
//
//
//
//        anotherVC.navigationController?.pushViewController(detailVC, animated: true)
//

        
//        detailVC.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Hoefler Text", size: 10) as Any]
//        detailVC.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//        detailVC.navigationController?.navigationBar.isTranslucent = true
//        detailVC.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        detailVC.navigationController?.navigationBar.shadowImage = UIImage()
//        detailVC.navigationController?.navigationBar.barTintColor = .clear
//
//        navVC.modalPresentationStyle = .fullScreen
        
        
        // missing
//        self.present(navVC, animated: true)
