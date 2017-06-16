//
//  SecondViewController.swift
//  ExcelDemo
//
//  Created by Migu on 2017/6/16.
//  Copyright © 2017年 VIctorChee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var contentTableView: UITableView!
    
    let leftData = [[1, 2, 3, 4, 5, 6, 7, 8, 9], ["a", "b", "c"]]
    let topData = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topCollectionView.register(UINib.init(nibName: String(describing: LabelCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "Cell")
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

extension SecondViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return leftData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.lable.text = "\(leftData[indexPath.section][indexPath.item])"
        cell.data = topData
        
        cell.collectionView.contentOffset = topCollectionView.contentOffset
        cell.didScroll = { offset in
            self.topCollectionView.contentOffset.x = offset.x
            
            for item in tableView.visibleCells as! [TableViewCell] {
                item.collectionView.contentOffset.x = offset.x
            }
        }
        
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
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

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LabelCollectionViewCell
        cell.label.text = String(topData[indexPath.item])
        return cell
    }
}

extension SecondViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(topCollectionView) {
            for item in contentTableView.visibleCells as! [TableViewCell] {
                item.collectionView.contentOffset.x = scrollView.contentOffset.x
            }
        }
    }
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [Int]?
    var didScroll: ((CGPoint) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: String(describing: LabelCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LabelCollectionViewCell
        cell.label.text = String(data![indexPath.item])
        return cell
    }
}

extension TableViewCell: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView.contentOffset)
    }
}
