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
    func setupUI(isDetail:Bool) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let logo = UIImage(named: "basket")
        navbarLabel.tag = 20
        let imageView = UIImageView(image:logo)
        imageView.tag = 10
        if !isDetail {
            if let navigationBar = self.navigationController?.navigationBar {
                self.navigationItem.title = "Mini Bakkal"
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
            if let views = navigationController?.navigationBar.subviews {
                for view in views {
                    view.removeFromSuperview()
                }
            }
            self.navigationItem.title = "Sepet"
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sil", style: .plain, target: self, action: #selector(deleteTapped))
            navigationItem.leftBarButtonItem?.tintColor = .red
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kapat", style: .plain, target: self, action: #selector(closeTapped))
        }
    }
    @objc func deleteTapped(){
        
    }
    @objc func closeTapped(){
        
    }
    func refresh() {
        navbarLabel.text = "\(Global.shared.totalProduct)"
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    }
}
