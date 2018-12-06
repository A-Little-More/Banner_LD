//
//  LDBannerView.swift
//  Banner_LD
//
//  Created by lidong on 2018/12/5.
//  Copyright © 2018年 macbook. All rights reserved.
//

import UIKit

private let itemsNumber = 10_0000

/**
 *  轮播图数据源
 */
protocol LDBannerViewDataSource: class {
    //返回轮播图的数量
    func bannerView(numberOfItem bannerView: LDBannerView) -> Int
    //返回轮播图的样式 自定制UICollectionViewCell
    func bannerView(_ bannerView: LDBannerView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    //返回页码指示器
    func bannerView(pageControl bannerView: LDBannerView) -> UIControl?
}

/**
 *  轮播图的交互
 */
protocol LDBannerViewDelegate: class {
    //点击轮播图
    func bannerView(_ bannerView: LDBannerView, _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class LDBannerView: UIView {
    
    //自定制轮播图需遵循此协议获得交互信息
    weak var delegate: LDBannerViewDelegate?
    
    //自定制轮播图需遵循此协议提供数据源
    weak var dataSource: LDBannerViewDataSource?
    
    //是否需要隐藏pageControl
    var isHiddenPageControl: Bool = false {
        didSet {
            self.pageControl?.isHidden = self.isHiddenPageControl
        }
    }
    
    //是否需要自动滚动
    var isAutoScroll: Bool = true
    
    //滚动动画的时间 默认5.0s
    var animalSeconds: Float = 5.0
    
    //自定制轮播图需注册cell
    func register(_ cellClass: AnyClass, forCellWithReuseIdentifier identifier: String) {
        self.collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    //刷新数据 添加滚动
    func reloadData() {
        self.collectionView.reloadData()
    
        //初始化collectionView的contentOffset
        self.itemsCount = self.dataSource?.bannerView(numberOfItem: self) ?? 0
    
        //设置pageControl
        if let dataSource = self.dataSource, let pageControl = dataSource.bannerView(pageControl: self) {
            self.pageControl = pageControl
            self.addSubview(pageControl)
            pageControl.frame = CGRect(x: 0, y: self.bounds.height - 25, width: pageControl.bounds.width, height: pageControl.bounds.height)
            pageControl.center.x = self.center.x
        }
        
        if self.itemsCount > 1 {
            let startIndexPath = IndexPath(row: self.itemsCount * itemsNumber / 2, section: 0)
            self.collectionView.scrollToItem(at: startIndexPath, at: .left, animated: false)
            
            self.endBannerScroll()
            self.startBannerScroll()
            self.pageControl?.isHidden = false
        } else {
            self.pageControl?.isHidden = true
        }
        
    }
    
    //开始滚动
    func startBannerScroll() {
        if self.itemsCount > 1 && self.isAutoScroll{
            self.addCycleTimer()
        }
    }
    //结束滚动
    func endBannerScroll() {
        self.removeCycleTimer()
    }
    
    //轮播图的数量
    private var itemsCount: Int = 0
    
    //轮播图的控制器 collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    //页码指示器
    var pageControl: UIControl?
    
    //定时器
    private var cycleTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        self.addSubview(self.collectionView)
        self.collectionView.frame = self.bounds
    }
    
}

//MARK: UICollectionViewDelegate，UICollectionViewDataSource，UICollectionViewDelegateFlowLayout

extension LDBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.bannerView(numberOfItem: self) == 1 ? 1 : dataSource.bannerView(numberOfItem: self) * itemsNumber
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let dataSource = self.dataSource {
            cell = dataSource.bannerView(self, collectionView, cellForItemAt: indexPath)
            return cell
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            delegate.bannerView(self, collectionView, didSelectItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}

extension LDBannerView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        if let pageControl = self.pageControl as? LDPageControl {
            pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (self.itemsCount == 0 ? 1 : self.itemsCount)
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.endBannerScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startBannerScroll()
    }
    
}

//MARK:- 定时器控制
extension LDBannerView {
    
    private func addCycleTimer() {
        
        self.cycleTimer = Timer(fireAt: Date(timeIntervalSinceNow: TimeInterval(animalSeconds)), interval: TimeInterval(animalSeconds), target: self, selector: #selector(cycleTimerAction), userInfo: nil, repeats: true)
        
        RunLoop.main.add(self.cycleTimer!, forMode: .common)
    }
    
    private func removeCycleTimer() {
        
        self.cycleTimer?.invalidate()
        self.cycleTimer = nil
        
    }
    
    @objc private func cycleTimerAction() {
        let currentOffsetX = self.collectionView.contentOffset.x
        let offsetX = currentOffsetX + self.collectionView.bounds.width
        
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}
