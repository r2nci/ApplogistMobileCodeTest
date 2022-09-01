//
//  BaseVC.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 31.08.2022.
//

import Foundation
import UIKit
class BaseVC : UIViewController {
    var navbarLabel = UILabel()
    var uniqArray: [ItemListModel] = []
    var deneme: [ItemListModel] = []
    func setupUI(isDetail:Bool) {
        let logo = UIImage(named: "basket")
        let imageView = UIImageView(image:logo)
        if !isDetail {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
     
            if let navigationBar = self.navigationController?.navigationBar {
                imageView.addGestureRecognizer(tap)
                imageView.frame = CGRect(x: navigationBar.frame.size.width-60, y: 0, width: navigationBar.frame.height, height: navigationBar.frame.height)
                navbarLabel = UILabel(frame: CGRect(x: navigationBar.frame.size.width-25, y: -20, width: navigationBar.frame.height, height: navigationBar.frame.height))
                refresh()
                navigationBar.addGestureRecognizer(tap)
                navigationBar.addSubview(imageView)
                navigationBar.addSubview(navbarLabel)
            }
        }
        else {
            
        }
    }
    func refresh() {
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    }
}
