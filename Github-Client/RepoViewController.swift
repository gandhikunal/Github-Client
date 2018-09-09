//
//  RepoViewController.swift
//  Github-Client
//
//  Created by Kunal Gandhi on 07.09.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import UIKit
import Alamofire

class RepoViewController: UITableViewController {
    
    var repositories = [Repository]()
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webService = WebService()
        webService.setLoadingScreen(tableView: tableView, spinner: spinner, loadingView: loadingView, loadingLabel: loadingLabel)
        webService.fetchRepos { (result) in
            switch result {
            case .sucess(let repoResult):
                self.repositories = repoResult
                webService.removeLoadingScreen(spinner: self.spinner, loadingView: self.loadingView, loadingLabel: self.loadingLabel)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(repositories.count)
        return repositories.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repo Cell", for: indexPath) as! RepoTableViewCell
        cell.configureSelf(data: repositories[indexPath.row])
        return cell
    }
   


   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "Repository Details" else { print("Invalid Segue Identifier"); return}
        guard let indexPath = self.tableView.indexPathForSelectedRow else { print("Cannot get index path."); return }
        guard let destinationVC = segue.destination as? RepoDetailsViewController else { print("View Controller downcasting failed."); return }
        destinationVC.repositoryDetail = repositories[indexPath.row]
    }
    

}
