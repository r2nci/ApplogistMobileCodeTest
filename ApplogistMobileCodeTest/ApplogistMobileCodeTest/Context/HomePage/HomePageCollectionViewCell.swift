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
        buttonMinusOutlet.isHidden = false
        labelCount.isHidden = false
        guard let currentItem = currentItem else {
            return
        }
        if !Global.shared.itemList.isEmpty {
            if let index = Global.shared.itemList.firstIndex(of: currentItem) {
                Global.shared.itemList[index].amount += 1
                }
            else {
                Global.shared.itemList.append(currentItem)
                currentItem.amount += 1
            }
        } else {
            Global.shared.itemList.append(currentItem)
            Global.shared.itemList.first?.amount += 1
        }

        refresh()
    }
    
    @IBAction func buttonMinusAction(_ sender: UIButton) {
        guard let currentItem = currentItem else {
            return
        }
        for item in Global.shared.itemList {
            if currentItem.id == item.id {
                if let index = Global.shared.itemList.firstIndex(of: currentItem) {
                    Global.shared.itemList[index].amount -= 1
                    }
               
            }
        }
        refresh()
        if currentItem.amount == 0  {
            if let index = Global.shared.itemList.firstIndex(of: currentItem) {
                Global.shared.itemList.remove(at: index)
                }
         
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
        if currentItem?.amount != 0 {
            labelCount.text = "\(currentItem?.amount ?? 0)"
            buttonPlusOutlet.isEnabled = true
            buttonPlusOutlet.isHidden = false
            buttonMinusOutlet.isHidden = false
            labelCount.isHidden = false
            buttonMinusOutlet.isEnabled = true
        } else {
            buttonPlusOutlet.isEnabled = true
            buttonPlusOutlet.isHidden = false
            buttonMinusOutlet.isHidden = true
            labelCount.isHidden = true
            buttonMinusOutlet.isEnabled = false
        }
        refresh()
    }
    
    func refresh() {
        self.delegate?.refreshBasket()
        if currentItem?.amount == currentItem?.stock ?? 0 {
            buttonPlusOutlet.isEnabled = false
        } else {
            buttonPlusOutlet.isEnabled = true
        }
        guard let currentItem = currentItem else {
            return
        }
        self.labelCount.text = "\(currentItem.amount )"
    }

}
