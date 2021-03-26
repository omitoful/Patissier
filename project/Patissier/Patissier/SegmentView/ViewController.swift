//
//  ViewController.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/9.
//

import UIKit

class SegmentViewController: UIViewController, ProductManagerDelegate {
    func manager(_ manager: ProductManager, didFetch profile: [Profile]) {
        print(profile)
        let info = profile[0]
        self.userName.text = info.profileName
    }
    
    func manager(_ manager: ProductManager, didFetch products: [Product]) {
        return ()
    }
    
    func manager(_ manager: ProductManager, didFetch products: [ProductComments]) {
        return ()
    }
    
    func manager(_ manager: ProductManager, didFailWith error: Error) {
        return ()
    }
    
    
    @IBOutlet weak var userName: UILabel!
    var offset: Int = 0
    var count: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let productManager = ProductManager.init()
        productManager.delegate = self
        let _ = productManager.fetchproductsProfile(offset: self.offset, count: self.count)
        
    }
}
