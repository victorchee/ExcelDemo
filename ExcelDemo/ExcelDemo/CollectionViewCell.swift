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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30)
        let label = UILabel(frame: view.bounds.insetBy(dx: 15, dy: 0))
        label.text = String(section)
        view.addSubview(label)
        return view
    }
}
