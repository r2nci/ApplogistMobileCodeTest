//
//  BasketDetailViewController.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import UIKit

class BasketDetailViewController: BaseVC {
    
    var callback : ((ItemListModel?,Bool) -> Void)?
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib.init(nibName: "BasketDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "BasketDetailTableViewCell")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var buttonSendDataOutlet: UIButton! {
        didSet {
            buttonSendDataOutlet.contentHorizontalAlignment = .right
            buttonSendDataOutlet.setTitle(
                "Sepeti Onayla", for: .normal)
        }
    }
    @IBOutlet weak var labelNoData: UILabel!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var labelTotal: UILabel!
    var viewModel : BasketDetailViewModel = {
        return BasketDetailViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(isDetail: true)
        updateUI()
        viewModel.delegate = self
    }
    func updateUI(){
        labelTotal.text = "Toplam Tutar: ₺\(Global.shared.totalAmount)"
        if Global.shared.itemList.isEmpty {
            noDataView.isHidden = false
            labelNoData.text = "Sepette ürün bulunamadı."
            
        } else {
            noDataView.isHidden = true
            self.tableView.reloadData()
        }
    }
    override func deleteTapped() {
        if !Global.shared.itemList.isEmpty {
            self.popupAlert(title: "Uyarı", message: "Ürünlerin hepsi silinecek", actionTitles: ["Tamam","İptal"], actions: [{action1 in
                Global.shared.itemList.removeAll()
                self.labelTotal.text = nil
                self.tableView.reloadData()
            },{ action2 in
                self.dismiss(animated: true)
            }])
        }
    }
    @IBAction func buttonApprove(_ sender: UIButton) {
        startLoading()
        if Global.shared.itemList.isEmpty {
            stopLoading()
            popupAlert(title: "Hata", message: "Sepette Ürün bulunamadı", actionTitles: ["Tamam"], actions: [{action1 in
                
            }])
        } else {
        viewModel.getListReq()
        }
    }
    override func closeTapped() {
        self.navigationController?.popViewController(animated: true)
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
        return 80
    }
}

extension BasketDetailViewController: BasketDetailTVCDelegate {
    func refreshTable(currentItem:ItemListModel) {
        if let cb = callback {
            cb(currentItem,false)
        }
        updateUI()
        tableView.reloadData()
    }
}

extension BasketDetailViewController: BasketDetailVMMDelegate {
    func getOrderResponse(order: Order) {
        stopLoading()
        self.popupAlert(title: "Uyarı", message: order.message, actionTitles: ["Tamam"], actions:[{action1 in
            Global.shared.itemList.removeAll()
            if let cb = self.callback {
                cb(nil,true)
            }
            self.labelTotal.text = nil
            self.navigationController?.popViewController(animated: true)
            self.tableView.reloadData()
        }])
           
        }
    
    func getErr(err: ErrorModel?) {
        stopLoading()
        self.popupAlert(title: "Uyarı", message: err?.description, actionTitles: ["Tamam"], actions:[{action1 in
        }])
    }
    
    
}
