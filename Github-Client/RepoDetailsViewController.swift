//
//  RepoDetailsViewController.swift
//  Github-Client
//
//  Created by Kunal Gandhi on 07.09.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var repositoryDetail: Repository?
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    @IBOutlet weak var branchTableView: UITableView!
    @IBOutlet weak var collaboratorTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let repositoryBranches = repositoryDetail?.branches else { return 0 }
        guard let repositoryCollaborators = repositoryDetail?.collaborators else { return 0 }
        if tableView == self.branchTableView {
            return (repositoryBranches.count)
        } else if tableView == self.collaboratorTableView {
            return (repositoryCollaborators.count)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repositoryBranches = repositoryDetail?.branches else { return UITableViewCell() }
        guard let repositoryCollaborators = repositoryDetail?.collaborators else { return UITableViewCell() }
        
        if tableView == self.branchTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Branch Cell", for: indexPath) as! BranchTableViewCell
            cell.configureSelf(data: repositoryBranches[indexPath.row].branchName)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Collaborator Cell", for: indexPath) as! CollaboratorTableViewCell
            cell.configureSelf(name: repositoryCollaborators[indexPath.row].loginName, type: repositoryCollaborators[indexPath.row].type)
            return cell
        }
//        cell.configureSelf(data: [indexPath.row])

    }
    
    override func viewDidLoad() {
        branchTableView.delegate = self
        branchTableView.dataSource = self
        collaboratorTableView.dataSource = self
        
        super.viewDidLoad()
        guard let ownerName = repositoryDetail?.owner.login else { print("invalid owner details, cannot form query."); return }
        guard repositoryDetail != nil else { print("Found Nil value while accessing an optional."); return }
        
        
        
        let webService = WebService()
        webService.setLoadingScreen(tableView: branchTableView, spinner: spinner, loadingView: loadingView, loadingLabel: loadingLabel)
        webService.fetchCollaborator(ownerName: ownerName, reposName: (repositoryDetail?.name)!) { (result) in
            switch result {
            case .sucess (let values):
                self.repositoryDetail!.branches = values.0
                self.repositoryDetail!.collaborators = values.1
                self.branchTableView.reloadData()
                self.collaboratorTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            webService.removeLoadingScreen(spinner: self.spinner, loadingView: self.loadingView, loadingLabel: self.loadingLabel)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
