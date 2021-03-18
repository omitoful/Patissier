//
//  rootViewController.swift
//  Patissier
//
//  Created by 陳冠甫 on 2021/3/11.
//

import UIKit
import FBSDKLoginKit
import Foundation

class RootViewController: UIViewController {

    var gradient: CAGradientLayer = CAGradientLayer()
    let leftColor = UIColor.blue.withAlphaComponent(0.7).cgColor
    let rightColor = UIColor.systemBlue.withAlphaComponent(0.7).cgColor
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //BGColor
        self.view.backgroundColor = .white

        //Imgae
        bgImageView.image = UIImage(named: "image-landing")
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.alpha = 0.85

        //Gradient
        gradient.colors = [leftColor,rightColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradient, at: 1)

        //Title
        titleView.layer.shadowColor = UIColor.black.cgColor
        titleView.layer.shadowRadius = 3.0
        titleView.layer.shadowOpacity = 0.8
        titleView.layer.shadowOffset = CGSize(width: 2, height: 2)


        //FB Sign In Button
        signInBtn.layer.cornerRadius = 5
        signInBtn.addTarget(self, action: #selector(RootViewController.tapToLogin), for: .touchUpInside)
    }

    @objc func tapToLogin() {
        
        let userdefault = UserDefaults.standard
        
        if userdefault.value(forKey: "Token") != nil {
            self.afterLogin()
        } else {
            let loginManager: LoginManager = LoginManager.init()
            
            loginManager.logIn(permissions: ["public_profile","email"]
                               , viewController: self){ loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case.cancelled:
                    print("Cancel")
                case.success(granted: let grantedPermissons, let declinedPermissions, let accessToken):
                    print("Log in!")
    //                print(grantedPermissons)
    //                print(declinedPermissions)
    //                print(accessToken)
               
                    let token: AccessToken? = AccessToken.current
                    if let finaltoken: String = token?.tokenString {
                        print(finaltoken)
                        
                        // 切換畫面至 collectionViewController
                        self.afterLogin()
                        
                        
                        //更新 access token
                        var components = URLComponents()

                        components.scheme = "https"
                        components.host = "api.tinyworld.cc"
                        components.path = "/patissier/v1/sign-in/facebook"

                        if let endpointURL = components.url {
                            print(endpointURL)

                        var request = URLRequest(url: endpointURL)

                        request.httpMethod = "POST"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                            
                        let dic:[String: Any] = [
                                "access_token": "\(finaltoken)"
                            ]
                            do {
                                let dataReq = try JSONSerialization.data(withJSONObject: dic)

                                request.httpBody = dataReq
                                print(request)

                                let session = URLSession.shared
                                
                                let task = session.dataTask (
                                    with: request,
                                    completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                                    if let error = error {
                                        print("\(error)")
                                        return
                                    }
                                    guard let data = data else {
                                        print("NO Data.")
                                        return
                                    }

                                    do {
                                        let json = try JSONSerialization.jsonObject(with: data)
                                        print(json)
                                        if let rootDic = json as? [String: Any] {
                                            if let dataValue = rootDic["data"] {
                                                if let data = dataValue as? [String: Any] {
                                                    if let titleValue = data["token"] {
                                                        if let title = titleValue as? String {

                                                            let post = Post(title: title)
                                                            // save the Token
                                                            
                                                            userdefault.set(title, forKey: "Token")

                                                            print(post)

                                                        } else {
                                                            print("title is not String")
                                                        }
                                                    } else {
                                                        print("no title")
                                                    }
                                                } else {
                                                    print("data is not dic")
                                                }
                                            } else {
                                                print("no data")
                                            }
                                        }
                                    } catch {
                                        print("\(error)")
                                    }
                                })
                                task.resume()
                                
                                return ()
                                
                            } catch {
                                print("error")
                            }
                        }
                        else {
                            print("error")
                        }
                        
                    } else {
                        print("error")
                    }
                }
            }
        }
    }

    
    func afterLogin() -> Void {
        
//        let changeVC: UICollectionViewController = CollectionViewController.init()
        
        //用storyboard 初始化
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        
        let navVC: UINavigationController = UINavigationController.init(rootViewController: secondVC)
        secondVC.title = "Patissier"
        secondVC.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Hoefler Text", size: 10) as Any]
        secondVC.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        secondVC.navigationController?.navigationBar.isTranslucent = true
        secondVC.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        secondVC.navigationController?.navigationBar.shadowImage = UIImage()
        secondVC.navigationController?.navigationBar.barTintColor = .clear
        
        navVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(navVC, animated: true, completion: nil)
    }
}

struct Post {
    let title : String
}
//let post: Post = Post.init(title: "")
//post.title
//
//final class Lion {
//
//    let leg: Int
//
//    init(numberOfLegs: Int) {
//        self.legs = numberOfLegs
//    }
//
//    func awakeUp() {
//        let legs = 4
//        print(legs)
//
//        self.makeSounds()
//    }
//
//    func makeSounds() -> Void {
//        print(legs)
//        print("Roar")
//        return ()
//
//        print("123")
//    }
//
//}
//
//Lion.init(numberOfLegs: ())
//
//Lion(numberOfLegs: <#T##Int#>)
//
//func name(param1: Int, param2: String) -> String {
//
//
//    return "result"
//}

//func afterLogin() -> Void {
//
//    let rootVC: UICollectionViewController = CollectionViewController.init()
//    let navVC: UINavigationController = UINavigationController.init(rootViewController: rootVC)
//
//    rootVC.title = "Patissier"
//
//    rootVC.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Hoefler Text Black", size: 8.0) as Any]
//    rootVC.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//    rootVC.navigationController?.navigationBar.isTranslucent = true
//    rootVC.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    rootVC.navigationController?.navigationBar.shadowImage = UIImage()
//    rootVC.navigationController?.navigationBar.barTintColor = .clear
//
//    navVC.present(rootVC, animated: false)
//    
//}
