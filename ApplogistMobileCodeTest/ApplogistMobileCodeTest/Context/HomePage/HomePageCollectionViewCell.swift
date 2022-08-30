//
//  HomePageCollectionViewCell.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import UIKit
import SDWebImage
protocol HomePageCollectionViewDelegate: AnyObject {
    func refreshBasket()
}

class HomePageCollectionViewCell: UICollectionViewCell {
    var delegate: HomePageCollectionViewDelegate?
    var currentItem : ItemListModel?
    var itemCount:Int = 0
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleToFill
        }
    }
    
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.layer.borderColor = UIColor.gray.cgColor
            stackView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var buttonMinusOutlet: UIButton! {
        didSet {
            buttonMinusOutlet.isHidden = true
        }
    }
    @IBOutlet weak var buttonPlusOutlet: UIButton!
    @IBOutlet weak var labelCount: UILabel! {
        didSet {
            labelCount.isHidden = true
        }
    }
    @IBOutlet weak var labelProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonPlusAction(_ sender: UIButton) {
        itemCount+=1
        buttonMinusOutlet.isHidden = false
        labelCount.isHidden = false
        guard let currentItem = currentItem else {
            return
        }

        Global.shared.itemList.append(currentItem)
        print(Global.shared.totalAmount)
        refresh()
    }
    
    @IBAction func buttonMinusAction(_ sender: UIButton) {
        guard let currentItem = currentItem else {
            return
        }
        if let index = Global.shared.itemList.firstIndex(of: currentItem) {
            Global.shared.itemList.remove(at: index)
        }
        print(Global.shared.totalAmount)
        refresh()
        itemCount-=1
        if itemCount == 0  {
            buttonMinusOutlet.isHidden = true
            labelCount.isHidden = true
        }
        refresh()
    }
    
    func configure(item:ItemListModel) {
        self.currentItem = item
        imageView.sd_setImage(with: URL(string: item.imageUrl ?? ""),placeholderImage: UIImage(named: "placeholder") )
        labelPrice.text = "\(item.price ?? 0.0)"
        labelProductName.text = item.name
    }
    
    func refresh() {
        self.delegate?.refreshBasket()
        if itemCount == currentItem?.stock ?? 0 {
            buttonPlusOutlet.isEnabled = false
        } else {
            buttonPlusOutlet.isEnabled = true
        }
        self.labelCount.text = "\(itemCount)"
    }

}
