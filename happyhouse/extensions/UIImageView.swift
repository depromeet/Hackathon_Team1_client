//
//  UIImageView.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(url: URL, placeholder: UIImage? = nil) {
        self.kf.setImage(with: url, placeholder: placeholder)
    }
    
    func setImage(urlString: String, placeholder: UIImage? = nil) {
        let url = URL(string: urlString)
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}
