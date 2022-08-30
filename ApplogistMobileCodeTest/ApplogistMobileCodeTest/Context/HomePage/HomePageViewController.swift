//
//  HomePageViewController.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import UIKit

class HomePageViewController: UIViewController {
    
    var itemList : [ItemListModel] = []
    var navbarLabel = UILabel()
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
        if let navigationBar = self.navigationController?.navigationBar {
            let logo = UIImage(named: "basket")
            
            let imageView = UIImageView(image:logo)
            imageView.frame = CGRect(x: navigationBar.frame.size.width-60, y: 0, width: navigationBar.frame.height, height: navigationBar.frame.height)
            navbarLabel = UILabel(frame: CGRect(x: navigationBar.frame.size.width-25, y: -20, width: navigationBar.frame.height, height: navigationBar.frame.height))
            refresh()
            navigationBar.addSubview(imageView)
            navigationBar.addSubview(navbarLabel)
        }
        // Do any additional setup after loading the view.
    }
    
    func refresh() {
        self.navbarLabel.text = "\(Global.shared.itemList.count)"
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
