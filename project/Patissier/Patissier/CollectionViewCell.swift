//
//  CollectionViewCell.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/9.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var iconHeart: UIImageView!
    @IBOutlet weak var picLabel: UILabel!
    @IBOutlet weak var iconPic: UIImageView!
    
    
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
    
}

func tappedInImage() -> Void {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let detailVC = storyboard.instantiateViewController(withIdentifier: "CellDetailTableViewController")
    let navVC: UINavigationController = UINavigationController.init(rootViewController: detailVC)
    detailVC.title = "Patissier"
    detailVC.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Hoefler Text", size: 10) as Any]
    detailVC.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    detailVC.navigationController?.navigationBar.isTranslucent = true
    detailVC.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    detailVC.navigationController?.navigationBar.shadowImage = UIImage()
    detailVC.navigationController?.navigationBar.barTintColor = .clear
    
    navVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
    
    
    return ()
}
