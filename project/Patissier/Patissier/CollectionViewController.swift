//
//  CollectionViewController.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/9.
//

import UIKit
import Foundation
import Alamofire
import UIScrollView_InfiniteScroll

//struct Property {
//
//    let name:[String] = ["Drink ONE","Drink TWO","Drink THREE","Drink FOUR","Drink FIVE","Drink SIX"]
//    let price:[String] = ["TWD $120","TWD $130","TWD $140","TWD $150","TWD $160","TWD $170"]
//
//}


//class Animal {
//
//}
//
//class Lion: Animal, Characteristics {
//    let foo: Int
//}
//
//class Cat: Lion {
//}
//
//class Dog: Animal, Characteristics {
//    let bar: String
//}
//
//let lion: Lion = Lion()
//
//let dog: Dog = Dog.init()
//
//let animals: [Animal] = [lion, dog, Dog.init(), Dog.init(), Lion.init(), Cat.init()]
//
//
//for animal: Animal in animals {
//    if let lion: Lion = animal as? Lion {
//        lion.foo
//    } else if let dog = animal as? Dog {
//        dog.bar
//    } else {
//        print("Unknown animal")
//    }
//}
//
//protocol Characteristics {}




class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout, ProductManagerDelegate, PushDelegate {
    
    func pushNewView(_ cell: CollectionViewCell) {
        
//        print("pushNewView & id:\(cell.productId)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "CellDetailTableViewController")
        let detailViewController: CellDetailTableViewController = viewController as! CellDetailTableViewController
        detailViewController.productID = cell.productId
        
        if let navigationController: UINavigationController = self.navigationController {
            navigationController.pushViewController(detailViewController, animated: true)
            print("Contains NavigationController")
        } else {
            print("No NavigationController")
        }
    }
    
    var products: [Product] = [] // need to take the value out to share to the other funcs
    var offset: Int = 0
    var count: Int = 9
    
    func manager(_ manager: ProductManager, didFetch products: [ProductComments]) {
        return ()
    }
    
    func manager(_ manager: ProductManager, didFetch products: [Product]) -> Void {
        
//        print(self.products)
        self.products.append(contentsOf: products)
//        print(self.products)
        self.offset += self.count
//        print("offset:\(self.offset)")
        // [A(3, 4, 5, 6, 7)]
        // [A(3, 4, 5, 6, 7),B(3, 4, 5, 6, 7)]
        // [A(3, 4, 5, 6, 7),B(3, 4, 5, 6, 7),C(3, 4, 5, 6, 7)]
        
        DispatchQueue.main.async (
                execute: { () -> Void in
                    let _ = self.collectionView.reloadData()
                    print("2")
                    return ()
                }
            )
        
        self.collectionView.addInfiniteScroll { (collectionView) -> Void in
            collectionView.performBatchUpdates({ () -> Void in
                // update collection view
                let productManager = ProductManager.init()
                productManager.delegate = self
                let _ = productManager.fetchProducts(offset: self.offset, count: self.count)

            }, completion: { (finished) -> Void in
                // finish infinite scroll animations
                    self.collectionView.finishInfiniteScroll()
                    self.collectionView.setShouldShowInfiniteScrollHandler { _ -> Bool in
                        return false
                }
            })
        }
                //[A(3, 4, 5, 6, 7)]
                //[B(3, 4, 5, 6, 7)]
    //            self?.products.append(contentsOf: products)
                //[A(3, 4, 5, 6, 7), A(3, 4, 5, 6, 7)]
                //[B(3, 4, 5, 6, 7), B(3, 4, 5, 6, 7)]
                
    //            ProductManager().fetchProducts()
    //            ProductManager.fetchProducts()
    }

    func manager(_ manager: ProductManager, didFailWith error: Error) -> Void {
        print(error)

        return ()
    }


    
    
//    var gradient: CAGradientLayer = CAGradientLayer()
//    let leftColor = UIColor.blue.withAlphaComponent(0.7).cgColor
//    let rightColor = UIColor.systemBlue.withAlphaComponent(0.7).cgColor
    
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        let productmanerger: ProductManager = ProductManager.init()
        let production: ProductManagerDelegate = self

        productmanerger.delegate = production
//        productmanerger.delegate = self
        
        let _ = productmanerger.fetchProducts(offset: self.offset, count: self.count)
//        let _ = productmanerger.fetchproductsProfile(offset: self.offset, count: self.count)
//        print("4")
        
        
//        self.collectionView.reloadData()
//        gradient.colors = [leftColor,rightColor]
//        gradient.locations = [0.0 , 1.0]
//        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
//        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 100)
//        self.view.layer.insertSublayer(gradient, at: 1)
        
//        navItem.title = "Patissier"
//        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Hoefler Text Black", size: 8.0)]
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.barTintColor = .clear
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        return () // Void.init()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        print(self.products.count)
        return self.products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let customCell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            
            customCell.delegate = self
            
            let product: Product = self.products[indexPath.row]
            customCell.productNameLabel.text = product.name
            customCell.productPriceLabel.text = "$ \(product.price)"
            customCell.productId = product.id
            
            return customCell
            
        } else {
            let cell: UICollectionViewCell = UICollectionViewCell()
            return cell
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
}





// gradient
// Download UIimage part-11
// load-more still need to debug

// 3/25
// compleate laod-more comments
// navigation back and title
// finish the segmentBtn View add the profile

//練習回答問題的時間
