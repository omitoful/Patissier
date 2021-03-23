//
//  ProductManager.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/23.
//

import Foundation
import Alamofire

// class Lion {}
protocol ProductManagerDelegate: AnyObject {
    
    func manager(_ manager: ProductManager, didFetch products: [Product])

    func manager(_ manager: ProductManager, didFailWith error: Error)
}

class ProductManager {
    static let shared = ProductManager.init()
    
//    weak var lion: Lion?
    
    weak var delegate: ProductManagerDelegate? = nil
    var age = 10
    
    func fetchProducts(offset: Int, count: Int) -> Void {
        // Alamofire
        let userdefault = UserDefaults.standard
        
        
        if let token = userdefault.value(forKey: "Token") as? String {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            AF.request("https://api.tinyworld.cc/patissier/v1/products?offset=\(offset)&count=\(count)",headers: headers)
                .responseJSON { response in
//                    print(response)
                    if let data: [String: Any] = response.value as? [String: Any] {
                        if let eachProduct: [[String: Any]] = data["data"] as? [[String: Any]] {
                            
                            var products: [Product] = []
                            
                            for i in 0..<(eachProduct.count) {
                                if let productID = eachProduct[i]["id"] {
                                    if let id = productID as? String {
                                        if let productName = eachProduct[i]["name"] {
                                            if let name = productName as? String {
                                                if let productPrice = eachProduct[i]["price"] {
                                                    if let price = productPrice as? Int {
                                                        
                                                        let product = Product(id: id, name: name, price: price)
                                                        products.append(product)
                                                        
                                                    } else {
                                                        enum reqError: Error {
                                                            case priceError
                                                        }
                                                        let error: reqError = reqError.priceError
                                                        self.delegate?.manager(self, didFailWith: error)
                                                        return ()
                                                    }
                                                } else {
                                                    enum reqError: Error {
                                                        case noPrice
                                                    }
                                                    let error: reqError = reqError.noPrice
                                                    self.delegate?.manager(self, didFailWith: error)
                                                    return ()
                                                }
                                            } else {
                                                enum reqError: Error {
                                                    case nameError
                                                }
                                                let error: reqError = reqError.nameError
                                                self.delegate?.manager(self, didFailWith: error)
                                                return ()
                                            }
                                        } else {
                                            enum reqError: Error {
                                                case noName
                                            }
                                            let error: reqError = reqError.noName
                                            self.delegate?.manager(self, didFailWith: error)
                                            return ()
                                        }
                                    } else {
                                        enum reqError: Error {
                                            case idError
                                        }
                                        let error: reqError = reqError.idError
                                        self.delegate?.manager(self, didFailWith: error)
                                        return () // completionHandler
                                    }
                                } else {
                                    enum reqError: Error {
                                        case noID
                                    }
                                    let error: reqError = reqError.noID
                                    self.delegate?.manager(self, didFailWith: error)
                                    return () // completionHandler
                                }
                            }
                            // self.lion.makeSounds()
                            // delegate === collectionViewController
                            if let delegate: ProductManagerDelegate = self.delegate  {
                                delegate.manager(self, didFetch: products)
                            } else {
                                print("No ProductManagerDelegate")
                            }
                            return () // completionHandler
                            
                        } else {
                            enum reqError: Error {
                                case noData
                            }
                            let error: reqError = reqError.noData
                            self.delegate?.manager(self, didFailWith: error)
                            return () // completionHandler
                        }
                    } else {
                        enum reqError: Error {
                            case dataError
                        }
                        let error: reqError = reqError.dataError
                        self.delegate?.manager(self, didFailWith: error)
                        return () // completionHandler
                    }
                }
            
//            AF.request("https://api.tinyworld.cc/patissier/v1/products/\(productId)",headers: headers)
//                .responseJSON { response in
//                    print("ID response: \(response)")
//                }
//
//            AF.request("https://api.tinyworld.cc/patissier/v1/products/A1269A6F-DB44-44C5-AF98-8628EC099868/comments?offset=\(offset)&count=\(count)",headers: headers)
//                .responseJSON { response in
//                    print("comments response: \(response)")
//                }

            return () // for fetchProducts()
        } else {
            enum reqError: Error {
                case tokenError
            }
            let error: reqError = reqError.tokenError
            self.delegate?.manager(self, didFailWith: error)
            return ()
        }
    }
    
    
    func fetchproductsComment(productId: String, offset: Int, count: Int) -> Void {
        let userdefault = UserDefaults.standard
        if let token = userdefault.value(forKey: "Token") as? String {
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            AF.request("https://api.tinyworld.cc/patissier/v1/products/\(productId)", headers: headers)
                .responseJSON { response in
//                    print("productId: \(response)")
                    if let data: [String: Any] = response.value as? [String: Any] {
                        if let eachData: [[String: Any]] = data["data"] as? [[String: Any]] {
                            if let productID = eachData[0]["id"] {
                            
                            
                            
                            AF.request("https://api.tinyworld.cc/patissier/v1/products/\(productID)/comments?offset=\(offset)&count=\(count)",headers: headers)
                                .responseJSON { response in
//                                    print("comments response: \(response)")
                                }
                            
                            
                            
                            } else {
                                enum reqError: Error {
                                    case NoID
                                }
                                let error: reqError = reqError.NoID
                                self.delegate?.manager(self, didFailWith: error)
                            }
                        } else {
                            enum reqError: Error {
                                case DataError
                            }
                            let error: reqError = reqError.DataError
                            self.delegate?.manager(self, didFailWith: error)
                        }
                    } else {
                        enum reqError: Error {
                            case noData
                        }
                        let error: reqError = reqError.noData
                        self.delegate?.manager(self, didFailWith: error)
                    }
                }

        } else {
            enum reqError: Error {
                case noToken
            }
            let error: reqError = reqError.noToken
            self.delegate?.manager(self, didFailWith: error)
        }
    }
    
    func fetchproductsProfile(offset: Int, count: Int) -> Void {
        let userdefault = UserDefaults.standard
        if let token = userdefault.value(forKey: "Token") as? String {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            AF.request("https://api.tinyworld.cc/patissier/v1/me",headers: headers)
                .responseJSON { response in
//                    print("profile: \(response)")
                    
                }
            AF.request("https://api.tinyworld.cc/patissier/v1/me/orders?offset=\(offset)&count=\(count)",headers: headers)
                .responseJSON { response in
//                    print("profile: \(response)")
                    // do not finish
                }
            
            

        } else {
            enum reqError: Error {
                case noToken
            }
            let error: reqError = reqError.noToken
            self.delegate?.manager(self, didFailWith: error)
        }
    }
    
}






// func of URLReqest:

//class ProductManager {
//
//    // Add a singleton property here
//    static let shared = ProductManager.init()
//
//    weak var delegate: ProductManagerDelegate?
//
//    func fetchProducts() -> Void {
//        var productComponent = URLComponents()
//        productComponent.scheme = "https"
//        productComponent.host = "api.tinyworld.cc"
//        productComponent.path = "/patissier/v1/products"
//        productComponent.queryItems = [
//            URLQueryItem(name: "offset", value: "3"),
//            URLQueryItem(name: "count", value: "5")
//        ]
//        if let productEndpoint: URL = productComponent.url {
//            var productReq = URLRequest(url: productEndpoint)
//
//            let userDefault = UserDefaults.standard
//            if let token = userDefault.value(forKey: "Token") {
//
//                productReq.httpMethod = "GET"
//                productReq.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//               print("Bearer \(token)")
//
//                let productSession = URLSession.shared
//
//                let task = productSession.dataTask(
//                    with: productReq,
//                    completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
//
//                        if let error: Error = error {
//                            self.delegate?.manager(self, didFailWith: error)
//                            return ()
//                        }
//                        guard let data: Data = data else {
//                            enum RequestError: Error {
//                                case noData
//                            }
//                            let error: RequestError = RequestError.noData
//                            self.delegate?.manager(self, didFailWith: error)
//                            return ()
//                        }
//
//                        do {
//                            let json: Any = try JSONSerialization.jsonObject(with: data)
//                            if let rootProduct: [String: Any] = json as? [String: Any] {
//                                if let productVal = rootProduct["data"] {
//                                    if let data = productVal as? [[String: Any]] {
//
//                                        var products: [Product] = []
//                                        for i in 0..<(data.count) {
//                                            if let dataID = data[i]["id"] {
//                                                if let id = dataID as? String {
//                                                    if let dataName = data[i]["name"] {
//                                                        if let name = dataName as? String {
//                                                            if let dataPrice = data[i]["price"] {
//                                                                if let price = dataPrice as? Int {
//
//                                                                    let product = Product(id: id, name: name, price: price)
//                                                                    products.append(product)
//
//                                                                } else {
//                                                                    enum RequestError: Error {
//                                                                        case NotPriceType
//                                                                    }
//                                                                    let error: RequestError = RequestError.NotPriceType
//                                                                    self.delegate?.manager(self, didFailWith: error)
//                                                                    return ()
//                                                                }
//                                                            } else {
//                                                                enum RequestError: Error {
//                                                                    case NoPrice
//                                                                }
//                                                                let error: RequestError = RequestError.NoPrice
//                                                                self.delegate?.manager(self, didFailWith: error)
//                                                                return ()
//                                                            }
//                                                        } else {
//                                                            enum RequestError: Error {
//                                                                case NotNameType
//                                                            }
//                                                            let error: RequestError = RequestError.NotNameType
//                                                            self.delegate?.manager(self, didFailWith: error)
//                                                            return ()
//                                                        }
//                                                    } else {
//                                                        enum RequestError: Error {
//                                                            case NoName
//                                                        }
//                                                        let error: RequestError = RequestError.NoName
//                                                        self.delegate?.manager(self, didFailWith: error)
//                                                        return ()
//                                                    }
//                                                } else {
//                                                    enum RequestError: Error {
//                                                        case NotIDType
//                                                    }
//                                                    let error: RequestError = RequestError.NotIDType
//                                                    self.delegate?.manager(self, didFailWith: error)
//                                                    return ()
//                                                }
//                                            } else {
//                                                enum RequestError: Error {
//                                                    case NoID
//                                                }
//                                                let error: RequestError = RequestError.NoID
//                                                self.delegate?.manager(self, didFailWith: error)
//                                                return ()
//                                            }
//                                        }
//
//                                        // end loop,then get the array of data
//                                        let _ = self.delegate?.manager(self, didFetch: products)
//
//                                        return ()
//                                    } else {
//                                        enum RequestError: Error {
//                                            case NotDataType
//                                        }
//                                        let error: RequestError = RequestError.NotDataType
//                                        self.delegate?.manager(self, didFailWith: error)
//                                        return ()
//                                    }
//                                } else {
//                                    enum RequestError: Error {
//                                        case NoData
//                                    }
//                                    let error:RequestError = RequestError.NoData
//                                    self.delegate?.manager(self, didFailWith: error)
//                                    return ()
//                                }
//                            } else {
//                                enum RequestError: Error {
//                                    case NotRootProduct
//                                }
//                                let error: RequestError = RequestError.NotRootProduct
//                                self.delegate?.manager(self, didFailWith: error)
//                                return ()
//                            }
//                        } catch(let error) {
//                            self.delegate?.manager(self, didFailWith: error)
//                            return ()
//                        }
//                    }
//                )
//                task.resume()
//                return () // end -> ViewDidLoad
//            } else {
//                enum RequestError: Error {
//                    case NoToken
//                }
//                let error: RequestError = RequestError.NoToken
//                self.delegate?.manager(self, didFailWith: error)
//                return ()
//            }
//        } else {
//            enum RequestError: Error {
//                case invalidEndpointURL
//            }
//            let error: RequestError = RequestError.invalidEndpointURL
//            self.delegate?.manager(self, didFailWith: error)
//            return ()
//        }
//    }
//}
