//
//  CollectionViewController.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/9.
//

import UIKit
import Foundation
import Alamofire

//struct Property {
//
//    let name:[String] = ["Drink ONE","Drink TWO","Drink THREE","Drink FOUR","Drink FIVE","Drink SIX"]
//    let price:[String] = ["TWD $120","TWD $130","TWD $140","TWD $150","TWD $160","TWD $170"]
//
//}

struct Product {
    let id: String
    let name: String
    let price: Int
}

class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,ProductManagerDelegate {
    
    // Alamofire
    func requestNewData() -> Void {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIyNkEwNUUzMC1FNkI2LTQwRjUtQjY5My1BQjc5MkI5MEM5MzIiLCJpc3MiOiIyM0RCREJERS05QUZFLTRDREQtOUVEQS0xMjU2M0RDNUM0NDMifQ.iEqda8kAT4jr2jBHEuLOlKLRK7-5GDpNPC9CyQRhCbY"
        ]
        let _ = AF.request("https://api.tinyworld.cc/patissier/v1/products?offset=3&count=5",headers: headers)
            .responseJSON { response in
//                debugPrint(response)
                let dict: [String: Any]? = response.value as? [String: Any]
                if let data: [String: Any] = dict {
                    if let productVal = data["data"] {
                        if let productArray = productVal as? [[String: Any]] {
                            
                            var tpproducts: [Product] = []
                            for i in 0..<(productArray.count) {
                                if let TPproductID = productArray[i]["id"] {
                                    if let id = TPproductID as? String {
                                        if let TPproductName = productArray[i]["name"] {
                                            if let name = TPproductName as? String {
                                                if let TPproductPrice = productArray[i]["price"] {
                                                    if let price = TPproductPrice as? Int {
                                                        
                                                        let product = Product(id: id, name: name, price: price)
                                                        tpproducts.append(product)
                                                        
                                                    } else {
                                                        print("Price Error")
                                                        return ()
                                                    }
                                                } else {
                                                    print("No Price")
                                                    return ()
                                                }
                                            } else {
                                                print("Name Error")
                                                return ()
                                            }
                                        } else {
                                            print("No Name")
                                            return ()
                                        }
                                    } else {
                                        print("ID Error")
                                        return ()
                                    }
                                } else {
                                    print("No ID")
                                    return ()
                                }
                            }
                            
                        } else {
                            print("productVal Error")
                            return ()
                        }
                    } else {
                        print("No Data")
                        return ()
                    }
                } else {
                    print("Data Error")
                    return ()
                    }
                }
        bothProduct.append(contentsOf: products)
        bothProduct.append(contentsOf: tpproduct)
        return ()
    }

    
    
    
    func manager(_ manager: ProductManager, didFetch products: [Product]) -> Void {
        
        self.products = products
//        print(self.products)
        let _ = DispatchQueue.main.async (
            execute: { () -> Void in
                let _ = self.collectionView.reloadData()
                return ()
            }
        )
        return ()
    }

    func manager(_ manager: ProductManager, didFailWith error: Error) -> Void {
        print(error)

        return ()
    }
    
    var gradient: CAGradientLayer = CAGradientLayer()
    let leftColor = UIColor.blue.withAlphaComponent(0.7).cgColor
    let rightColor = UIColor.systemBlue.withAlphaComponent(0.7).cgColor
    
    var products: [Product] = []
    var tpproduct: [Product] = []
    var bothProduct: [Product] = []
    var refreshControl = UIRefreshControl.init()
    
    
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        let productmanerger: ProductManager = ProductManager.init()
        let production: ProductManagerDelegate = self

        productmanerger.delegate = production
        let _ = productmanerger.fetchProducts()
        
        
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
        
        print(self.products.count)
        return self.products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let customCell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            let product: Product = self.products[indexPath.row]
            customCell.productNameLabel.text = product.name
            customCell.productPriceLabel.text = "$ \(product.price)"
            customCell.cellInfo()
            return customCell
            
        } else {
            let cell: UICollectionViewCell = UICollectionViewCell()
            return cell
        }
    }
}

protocol ProductManagerDelegate: AnyObject {
    
    func manager(_ manager: ProductManager, didFetch products: [Product])

    func manager(_ manager: ProductManager, didFailWith error: Error)
}


class ProductManager {

    // Add a singleton property here
    static let shared = ProductManager.init()

    weak var delegate: ProductManagerDelegate?

    func fetchProducts() -> Void {
        var productComponent = URLComponents()
        productComponent.scheme = "https"
        productComponent.host = "api.tinyworld.cc"
        productComponent.path = "/patissier/v1/products"
        productComponent.queryItems = [
            URLQueryItem(name: "offset", value: "3"),
            URLQueryItem(name: "count", value: "5")
        ]
        if let productEndpoint: URL = productComponent.url {
            var productReq = URLRequest(url: productEndpoint)
            
            let userDefault = UserDefaults.standard
            if let token = userDefault.value(forKey: "Token") {
                
                productReq.httpMethod = "GET"
                productReq.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//                print("Bearer \(token)")
                
                let productSession = URLSession.shared

                let task = productSession.dataTask(
                    with: productReq,
                    completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in

                        if let error: Error = error {
                            self.delegate?.manager(self, didFailWith: error)
                            return ()
                        }
                        guard let data: Data = data else {
                            enum RequestError: Error {
                                case noData
                            }
                            let error: RequestError = RequestError.noData
                            self.delegate?.manager(self, didFailWith: error)
                            return ()
                        }
                        
                        do {
                            let json: Any = try JSONSerialization.jsonObject(with: data)
                            if let rootProduct: [String: Any] = json as? [String: Any] {
                                if let productVal = rootProduct["data"] {
                                    if let data = productVal as? [[String: Any]] {
                                        
                                        var products: [Product] = []
                                        for i in 0..<(data.count) {
                                            if let dataID = data[i]["id"] {
                                                if let id = dataID as? String {
                                                    if let dataName = data[i]["name"] {
                                                        if let name = dataName as? String {
                                                            if let dataPrice = data[i]["price"] {
                                                                if let price = dataPrice as? Int {
                                                                    
                                                                    let product = Product(id: id, name: name, price: price)
                                                                    products.append(product)
                                                                    
                                                                } else {
                                                                    enum RequestError: Error {
                                                                        case NotPriceType
                                                                    }
                                                                    let error: RequestError = RequestError.NotPriceType
                                                                    self.delegate?.manager(self, didFailWith: error)
                                                                    return ()
                                                                }
                                                            } else {
                                                                enum RequestError: Error {
                                                                    case NoPrice
                                                                }
                                                                let error: RequestError = RequestError.NoPrice
                                                                self.delegate?.manager(self, didFailWith: error)
                                                                return ()
                                                            }
                                                        } else {
                                                            enum RequestError: Error {
                                                                case NotNameType
                                                            }
                                                            let error: RequestError = RequestError.NotNameType
                                                            self.delegate?.manager(self, didFailWith: error)
                                                            return ()
                                                        }
                                                    } else {
                                                        enum RequestError: Error {
                                                            case NoName
                                                        }
                                                        let error: RequestError = RequestError.NoName
                                                        self.delegate?.manager(self, didFailWith: error)
                                                        return ()
                                                    }
                                                } else {
                                                    enum RequestError: Error {
                                                        case NotIDType
                                                    }
                                                    let error: RequestError = RequestError.NotIDType
                                                    self.delegate?.manager(self, didFailWith: error)
                                                    return ()
                                                }
                                            } else {
                                                enum RequestError: Error {
                                                    case NoID
                                                }
                                                let error: RequestError = RequestError.NoID
                                                self.delegate?.manager(self, didFailWith: error)
                                                return ()
                                            }
                                        }
                                        
                                        // end loop,then get the array of data
                                        let _ = self.delegate?.manager(self, didFetch: products)
                                        
                                        return ()
                                    } else {
                                        enum RequestError: Error {
                                            case NotDataType
                                        }
                                        let error: RequestError = RequestError.NotDataType
                                        self.delegate?.manager(self, didFailWith: error)
                                        return ()
                                    }
                                } else {
                                    enum RequestError: Error {
                                        case NoData
                                    }
                                    let error:RequestError = RequestError.NoData
                                    self.delegate?.manager(self, didFailWith: error)
                                    return ()
                                }
                            } else {
                                enum RequestError: Error {
                                    case NotRootProduct
                                }
                                let error: RequestError = RequestError.NotRootProduct
                                self.delegate?.manager(self, didFailWith: error)
                                return ()
                            }
                        } catch(let error) {
                            self.delegate?.manager(self, didFailWith: error)
                            return ()
                        }
                    }
                )
                task.resume()
                return () // end -> ViewDidLoad
            } else {
                enum RequestError: Error {
                    case NoToken
                }
                let error: RequestError = RequestError.NoToken
                self.delegate?.manager(self, didFailWith: error)
                return ()
            }
        } else {
            enum RequestError: Error {
                case invalidEndpointURL
            }
            let error: RequestError = RequestError.invalidEndpointURL
            self.delegate?.manager(self, didFailWith: error)
            return ()
        }
    }
}

//UIimage的值

//gradient

//練習回答問題的時間

func partFourteenData() -> Void {
    var productIdComponent = URLComponents.init()
    productIdComponent.scheme = "https"
    productIdComponent.host = "api.tinyworld.cc"
    productIdComponent.path = "/patissier/v1/products/:id"
    
}
