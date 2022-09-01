//
//  BasketDetailTableViewCell.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import UIKit
import SDWebImage
protocol BasketDetailTVCDelegate: AnyObject {
    func refreshTable(currentItem:ItemListModel)
}
class BasketDetailTableViewCell: UITableViewCell {
    var delegate: BasketDetailTVCDelegate?
    var currentItem : ItemListModel?
    @IBOutlet weak var imageViewProduct: UIImageView!
    
    @IBOutlet weak var labelProductName: UILabel! {
        didSet {
            labelProductName.numberOfLines  = 0
        }
    }
    @IBOutlet weak var buttonMinusOutlet: UIButton!
    
    @IBOutlet weak var labelProductCount: UILabel!
    @IBOutlet weak var buttonPlusOutlet: UIButton!
    @IBOutlet weak var labelProductPrice: UILabel! {
        didSet {
            labelProductPrice.numberOfLines  = 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonMinusAction(_ sender: UIButton) {
        guard let currentItem = currentItem else {
            return
        }
        if let index = Global.shared.itemList.firstIndex(of: currentItem) {
            Global.shared.itemList[index].amount -= 1
            labelProductCount.text = "\(Global.shared.itemList[index].amount)"
            if currentItem.amount == currentItem.stock {
                buttonPlusOutlet.isEnabled = false
            } else if currentItem.amount == 0 {
                Global.shared.itemList.remove(at: index)
            }
            else {
                buttonPlusOutlet.isEnabled = true
            }
           
        }
        delegate?.refreshTable(currentItem:currentItem)
    }
    @IBAction func buttonPlusAction(_ sender: UIButton) {
        guard let currentItem = currentItem else {
            return
        }
        if let index = Global.shared.itemList.firstIndex(of: currentItem) {
            if currentItem.amount == currentItem.stock {
                buttonPlusOutlet.isEnabled = false
            } else {
                Global.shared.itemList[index].amount += 1
                buttonPlusOutlet.isEnabled = true
            }
            labelProductCount.text = "\(Global.shared.itemList[index].amount)"
        }
        delegate?.refreshTable(currentItem:currentItem)
    }
    
    func configure(item:ItemListModel) {
        currentItem = item
        if currentItem?.amount ?? 0 >= currentItem?.stock ?? 0 {
            buttonPlusOutlet.isEnabled = false
        } else {
            buttonMinusOutlet.isEnabled = true
        }
        imageViewProduct.sd_setImage(with: URL(string: item.imageUrl ?? ""),placeholderImage: UIImage(named: "placeholder") )
        labelProductPrice.text = "\(item.price ?? 0.0)"
        labelProductName.text = item.name
        labelProductCount.text = "\(item.amount)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
