//
//  CellDetailTableViewController.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/17.
//

import UIKit
import UIScrollView_InfiniteScroll

class CellDetailTableViewController: UITableViewController, ProductManagerDelegate {
    
    func manager(_ manager: ProductManager, didFetch products: [Product]) {
        
        print(products)
        let info = products[0]
        self.productPrice.text = "$ \(info.price)"
        self.productName.text = info.name
        
        return ()
    }
    
    func manager(_ manager: ProductManager, didFetch products: [ProductComments]) {
        
//        print(self.productComments) []
        self.productComments.append(contentsOf: products)
//        print(self.productComments) [have comments]
        self.offset += self.count
        
        DispatchQueue.main.async (
                execute: { () -> Void in
                    let _ = self.tableView.reloadData()
                    return ()
                }
            )
        self.tableView.addInfiniteScroll { (tableView) -> Void in
            tableView.performBatchUpdates({ () -> Void in
                // update tableView
                let productManager = ProductManager.init()
                productManager.delegate = self
                let _ = productManager.fetchproductsComment(productId: self.productID, offset: self.offset, count: self.count)
                
            }, completion: { (finished) -> Void in
                // finish infinite scroll animations
                self.tableView.finishInfiniteScroll()
                self.tableView.setShouldShowInfiniteScrollHandler { _ -> Bool in
                    return false
                }
            })
        }
    }
    
    func manager(_ manager: ProductManager, didFailWith error: Error) {
        print(error)
        return ()
    }
    

    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var AddCartBtn: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    var offset = 0
    var count = 9
    var productID = ""
    var productComments: [ProductComments] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the top of the UIView
        AddCartBtn.layer.cornerRadius = 5.0
        title = "Product"
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableView.automaticDimension
        //add the info in delegate(name,price)
        // if there is no comments, no lines
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        

        let productManager = ProductManager.init()
        productManager.delegate = self
        print(self.productID)
        let _ = productManager.fetchproductsComment(productId: self.productID, offset: self.offset, count: self.count)
        let _ = productManager.fetchProductDetail(productId: self.productID)
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.productComments.count
    }

    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TabelCell", for: indexPath) as! TableViewCell
        // Configure the cell...
        
        let productComment: ProductComments = self.productComments[indexPath.row]
        cell.commentName.text = productComment.userName
        cell.comment.text = productComment.text

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
