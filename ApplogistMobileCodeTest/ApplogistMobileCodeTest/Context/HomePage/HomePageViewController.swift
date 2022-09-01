//
//  HomePageViewController.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import UIKit

class HomePageViewController: BaseVC {
    
    var itemList : [ItemListModel] = []
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib.init(nibName: "HomePageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomePageCollectionViewCell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.allowsMultipleSelection = false
            collectionView.allowsSelection = true
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.layer.cornerRadius = 0
            collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    var viewModel : HomePageViewModel = {
        return HomePageViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getListReq()
        setupUI(isDetail: false)
        // Do any additional setup after loading the view.
    }
    
    override func refresh() {
        self.navbarLabel.text = "\(Global.shared.totalProduct)"
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
     @objc override func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let vc = BasketDetailViewController()
         navigationController?.pushViewController(vc, animated: true)
        vc.callback = {
            (item) in
            if let index = self.itemList.firstIndex(of: item) {
                self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
            self.refresh()
        }
    }
}


extension HomePageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionViewCell", for: indexPath) as? HomePageCollectionViewCell  else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.configure(item: itemList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let collectionViewSize = collectionView.frame.size
        let itemWidth: CGFloat = (collectionViewSize.width-20)/3
        return CGSize.init(width: itemWidth, height: collectionViewSize.height*0.3 )
    }
}

extension HomePageViewController: HomePageVMMDelegate {
    func getErr(err: ErrorModel) {
        
    }
    
    func getListResponse(itemList: [ItemListModel]) {
        self.itemList = itemList
        self.collectionView.reloadData()
    }
    
}
extension HomePageViewController: HomePageCollectionViewDelegate {
    func refreshBasket() {
        self.refresh()
    }
    
    
}
