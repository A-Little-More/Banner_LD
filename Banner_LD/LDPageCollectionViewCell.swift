//
//  LDPageCollectionViewCell.swift
//  Banner_LD
//
//  Created by lidong on 2018/12/5.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

class LDPageCollectionViewCell: UICollectionViewCell {
 
    lazy var pageLabel: UILabel = {
        let pageLabel = UILabel()
        pageLabel.layer.cornerRadius = 1.0
        pageLabel.layer.masksToBounds = true
        return pageLabel
    }()
    
    lazy var pageImageV: UIImageView = {
        let pageImageV = UIImageView()
        return pageImageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        self.contentView.addSubview(self.pageImageV)
        self.contentView.addSubview(self.pageLabel)
        
        self.pageImageV.frame = self.contentView.bounds
        self.pageLabel.frame = self.contentView.bounds
    }
    
}
