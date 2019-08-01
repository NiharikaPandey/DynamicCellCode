//
//  DisplayTableDataViewController.swift
//  DynamicCellCode
//
//  Created by Niharika on 31/07/19.
//  Copyright © 2019 Niharika. All rights reserved.
//

import UIKit
import Kingfisher

class DisplayTableDataViewController: UIViewController {

    fileprivate let cellReuseIdentifier = "cell"
    fileprivate var dataArray = [DataModel]()
    fileprivate let tableview = UITableView()
    var service = NetworkServiceCall()
    private let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getServiceData()
        configureTableView()
        navigationController?.navigationBar.barTintColor = UIColor.red
    }
    
    func configureTableView() {
        
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.white
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
        tableview.register(CustomTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        self.tableview.addSubview(self.refreshControl)
    }
    
    func getServiceData() {
        
        let url = URL(string: urlString)
        service.getData(fromURL: url!) { (data,title) in
            guard let data = data else{return}
            DispatchQueue.main.async {
                self.dataArray.removeAll()
                self.dataArray = data
                self.title = title
                self.tableview.reloadData()
            }
        }
    }
    
    // Add Refresh Control to Table View
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(DisplayTableDataViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getServiceData()
        self.tableview.reloadData()
        refreshControl.endRefreshing()
    }
}

extension DisplayTableDataViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CustomTableViewCell
        
        let dataModel = dataArray[indexPath.row]
        if let urlString = dataModel.dataImage{
        let resource = ImageResource(downloadURL:(URL(string: urlString)!), cacheKey: dataModel.dataImage)
        cell.profileImageView.kf.setImage(with: resource)
        }
        cell.nameLabel.text = dataModel.name
        cell.detailLabel.text = dataModel.details
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

