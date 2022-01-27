//
//  RandomView.swift
//  OBJC_test
//
//  Created by liu dante on 2022/1/27.
//

import UIKit

class RandomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
