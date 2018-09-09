//
//  WebService.swift
//  Github-Client
//
//  Created by Kunal Gandhi on 07.09.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum Result<T> {
    case sucess (T)
    case failure (Error)
}

class WebService {
    //let sessionManager = Alamofire.SessionManager.default
    // get the default headers
    
    let sessionManager = { () -> SessionManager in
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Authentication"] = "Basic Z2FuZGhpa3VuYWw6NzkyZmM1Nzc5YTQ1YTZmYTk3MWQ3NDUwM2Y5NGU2Mjg3MGUwMGMwMg=="
        
        // create a custom session configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        
        // create a session manager with the configuration
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        let username = "gandhikunal"
        let password = "792fc5779a45a6fa971d74503f94e62870e00c02"
        return sessionManager
    } ()
   
    
    func fetchCollaborator(ownerName: String, reposName: String, completion: @escaping (_ result: Result<([Branches],[Collaborator])>) -> ()) {
        
        let dispatchGroup = DispatchGroup()
        var resultBranches: [Branches]?
        var resultCollaborators: [Collaborator]?
//        var resultCollaborators = [Collaborator]()
//        resultCollaborators.append(Collaborator(loginName: "gandhikunal", type: "User"))
//        resultCollaborators.append(Collaborator(loginName: "priteshshah1983", type: "User"))
        var errorQuery: Error?
        
        let requestCollaborators = sessionManager.request("https://api.github.com/repos/\(ownerName)/\(reposName)/collaborators")
//        print(requestCollaborators.request!)
//        requestCollaborators.authenticate(user: username, password: password)
        debugPrint(requestCollaborators)
        
//        let requestBranches = sessionManager.request("https://api.github.com/repos/\(ownerName)/\(reposName)/branches")
//        requestBranches.authenticate(user: username, password: password)
//        debugPrint(requestBranches)
//       print("hello")
//        dispatchGroup.enter()
//        requestBranches.responseData { (response) in
//            guard let statusCode = response.response?.statusCode else { print("Query Failed"); return }
//            guard statusCode == 200 else { print("Invalid reponse code \(statusCode)"); return}
//            if let error = response.error {
//                errorQuery = error
//            } else {
//                let data = response.result.value
//                let decoder = JSONDecoder()
//                resultBranches = try! decoder.decode([Branches].self, from: data!)
////                completion(Result.sucess(resultBranches))
//            }
//            dispatchGroup.leave()
//        }
//
        dispatchGroup.enter()
        requestCollaborators.responseData { (response) in
            guard let statusCode = response.response?.statusCode else { print("Query Failed"); return }
//            guard statusCode == 200 else {
//                print("Invalid reponse code \(statusCode)");
//                return
//            }
            if let error = response.error {
                errorQuery = error
//                completion(Result.failure(error))
            }else {
                let data = response.result.value
                let decoder = JSONDecoder()
                let dataString = String(data: data!, encoding: .utf8)
                resultCollaborators = try! decoder.decode([Collaborator].self, from: data!)
                print("Kunal")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            if errorQuery != nil {
                completion(Result.failure(errorQuery!))
            } else {
                let answer = (resultBranches!,resultCollaborators!)
                completion(Result.sucess(answer))
            }
        }
    }
    
//    func fetchBranches(ownerName: String, reposName: String, completion: @escaping (_ result: Result<[Branches]>) -> ()) {
//        let requestBranches = sessionManager.request("https://api.github.com/repos/\(ownerName)/\(reposName)/branches")
//        requestBranches.authenticate(user: username, password: password)
//        requestBranches.responseData { (response) in
//            guard let statusCode = response.response?.statusCode else { print("Query Failed"); return }
//            guard statusCode == 200 else { print("Invalid reponse code \(statusCode)"); return}
//            guard let error = response.error else {
//                let data = response.result.value
//                let decoder = JSONDecoder()
//                let resultBranches = try! decoder.decode([Branches].self, from: data!)
//                completion(Result.sucess(resultBranches))
//                return
//            }
//            completion(Result.failure(error))
//        }
//    }
    
    func fetchRepos(completion: @escaping (_ result: Result<[Repository]>) -> ()) {
        let requestRepos = sessionManager.request("https://api.github.com/users/gandhikunal/repos")
//        requestRepos.authenticate(user: username, password: password)
        requestRepos.responseData { (response) in
            guard let statusCode = response.response?.statusCode else { print("Query Failed"); return }
            guard statusCode == 200 else { print("Invalid reponse code \(statusCode)"); return}
            guard let error = response.error else {
                let data = response.result.value
                let decoder = JSONDecoder()
                let reultRepos = try! decoder.decode([Repository].self, from: data!)
                completion(Result.sucess(reultRepos))
                return
            }
            completion(Result.failure(error))
        }
    }
    
    

    func setLoadingScreen(tableView: UITableView, spinner: UIActivityIndicatorView, loadingView: UIView, loadingLabel: UILabel) {
        let width: CGFloat = 140
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2)
        loadingLabel.textColor = UIColor.gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: x, y: y, width: 140, height: 30)
        
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        spinner.frame = CGRect(x: x+width, y: y, width: 30, height: 30)
        spinner.startAnimating()

        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        tableView.addSubview(loadingView)
        
    }
    
    func removeLoadingScreen(spinner: UIActivityIndicatorView, loadingView: UIView, loadingLabel: UILabel) {
        spinner.stopAnimating()
        loadingLabel.isHidden = true
        loadingView.removeFromSuperview()
        
    }
    
    
}
