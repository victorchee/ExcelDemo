//
//  ViewController.swift
//  ExcelDemo
//
//  Created by Migu on 2017/6/16.
//  Copyright © 2017年 VIctorChee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    let leftData = [[1, 2, 3, 4, 5, 6, 7, 8, 9], ["a", "b", "c"]]
    let topData = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return leftData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(leftData[indexPath.section][indexPath.row])"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(topCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TopCollectionViewCell
            cell.label.text = String(topData[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            cell.data = leftData
            cell.tableView.contentOffset = leftTableView.contentOffset
            cell.didScroll = { offset in
                self.leftTableView.contentOffset.y = offset.y
                
                for item in collectionView.visibleCells as! [CollectionViewCell] {
                    item.tableView.contentOffset.y = offset.y
                }
            }
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(topCollectionView) {
            contentCollectionView.contentOffset.x = scrollView.contentOffset.x
        } else if scrollView.isEqual(contentCollectionView) {
            topCollectionView.contentOffset.x = scrollView.contentOffset.x
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: leftTableView.frame.width, height: collectionView.frame.height)
    }
}

class TopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}
