//
//  ViewController.swift
//  Banner_LD
//
//  Created by lidong on 2018/12/5.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let pageItemSize = CGSize(width: 14, height: 14)
private let pageItemSpace: CGFloat = 8

private let bannerCell = "bannerCell"

class ViewController: UIViewController {

    var bannersCount = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let LDBanner: LDBannerView = LDBannerView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 200))
        LDBanner.delegate = self
        LDBanner.dataSource = self
        LDBanner.register(LDBannerCollectionViewCell.self, forCellWithReuseIdentifier: bannerCell)
        self.view.addSubview(LDBanner)
        
        LDBanner.reloadData()
        
    }

}

extension ViewController: LDBannerViewDelegate, LDBannerViewDataSource {
    
    func bannerView(numberOfItem bannerView: LDBannerView) -> Int {
        return bannersCount
    }
    
    func bannerView(_ bannerView: LDBannerView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCell, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func bannerView(_ bannerView: LDBannerView, _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了\(indexPath.item)")
    }
    
    func bannerView(pageControl bannerView: LDBannerView) -> UIControl? {
        let pageControl = LDPageControl(frame: CGRect(x: 0, y: 0, width: (pageItemSize.width + pageItemSpace) * CGFloat(bannersCount) - pageItemSpace, height: pageItemSize.height))
        pageControl.numberOfPages = bannersCount
        pageControl.pageItemSize = pageItemSize
        pageControl.pageItemSpace = pageItemSpace
//        pageControl.style = .labelStyle
//        pageControl.pageIndicatorTintColor = UIColor.white
//        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.style = .imageStyle
        pageControl.pageIndicatorImage = UIImage(named: "pageNormal")
        pageControl.currentPageIndicatorImage = UIImage(named: "pageSelected")
        return pageControl
    }
    
}
