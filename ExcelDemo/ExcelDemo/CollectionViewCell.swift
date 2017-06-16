//
//  CollectionViewCell.swift
//  ExcelDemo
//
//  Created by Migu on 2017/6/16.
//  Copyright © 2017年 VIctorChee. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tableView: UITableView!
    
    var data: [[Any]]?
    var didScroll: ((CGPoint) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CollectionViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(data?[indexPath.section][indexPath.row] ?? "")"
        return cell
    }
}

extension CollectionViewCell: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView.contentOffset)
    }
}
