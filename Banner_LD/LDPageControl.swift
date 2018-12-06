//
//  LDPageControl.swift
//  Banner_LD
//
//  Created by lidong on 2018/12/5.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let pageCell = "pageCell"

/**
 *  pageControl的style
 */
enum LDPageStyle {
    case labelStyle
    case imageStyle
}

class LDPageControl: UIControl {
    
    var numberOfPages = 0
    
    var currentPage = 0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var style: LDPageStyle = .labelStyle
    
    var pageIndicatorTintColor: UIColor?
    
    var currentPageIndicatorTintColor: UIColor?
    
    var pageIndicatorImage: UIImage?
    
    var currentPageIndicatorImage: UIImage?
    
    var pageItemSize: CGSize = CGSize.zero
    
    var pageItemSpace: CGFloat = 0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LDPageCollectionViewCell.self, forCellWithReuseIdentifier: pageCell)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        self.collectionView.frame = self.bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LDPageControl: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCell, for: indexPath) as! LDPageCollectionViewCell
        if style == .labelStyle {
            cell.pageImageV.isHidden = true
            cell.pageLabel.isHidden = false
            if indexPath.item == currentPage {
                cell.pageLabel.backgroundColor = currentPageIndicatorTintColor
            } else {
                cell.pageLabel.backgroundColor = pageIndicatorTintColor
            }
        } else {
            cell.pageImageV.isHidden = false
            cell.pageLabel.isHidden = true
            if indexPath.item == currentPage {
                cell.pageImageV.image = currentPageIndicatorImage
            } else {
                cell.pageImageV.image = pageIndicatorImage
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return pageItemSize
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return pageItemSpace
    }
    
}
