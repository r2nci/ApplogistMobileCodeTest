//
//  BasketDetailViewController.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import UIKit

class BasketDetailViewController: BaseVC {
    
    var callback : ((ItemListModel) -> Void)?
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib.init(nibName: "BasketDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "BasketDetailTableViewCell")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var labelTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(isDetail: true)
        self.tableView.reloadData()
        labelTotal.text = "\(Global.shared.totalAmount)"
    }
    
}

extension BasketDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.shared.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasketDetailTableViewCell", for: indexPath) as? BasketDetailTableViewCell  else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(item: Global.shared.itemList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension BasketDetailViewController: BasketDetailTVCDelegate {
    func refreshTable(currentItem:ItemListModel) {
        if let cb = callback {
                   cb(currentItem)
               }
        for item in uniqArray {
            if item.amount <= 0 {
                if let index = uniqArray.firstIndex(of: item) {
                    uniqArray.remove(at: index)
                }
            }
        }
        labelTotal.text = "\(Global.shared.totalAmount)"
        tableView.reloadData()
    }
    
    
}

