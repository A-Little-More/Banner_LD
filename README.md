# Banner_LD
# 这是一款超级简单就能实现的轮播控制器
# 轮播图的效果展示
![image](https://github.com/theGirlIsLost/Banner_LD/blob/master/Banner_label_LD.2018-12-06%2012_44_34.gif)
![image](https://github.com/theGirlIsLost/Banner_LD/blob/master/banner_imagePage_LD.2018-12-06%2012_45_10.gif)
# 代码实现
## LDBannerView最核心的显示视图
### bannerView的初始化
```
let LDBanner: LDBannerView = LDBannerView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 200))
LDBanner.delegate = self
LDBanner.dataSource = self
LDBanner.register(LDBannerCollectionViewCell.self, forCellWithReuseIdentifier: bannerCell)
self.view.addSubview(LDBanner)        
LDBanner.reloadData()     
```
### 代理实现(提供轮播图的数量，样式，点击事件以及pageControl的样式)
```
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
        pageControl.style = .labelStyle
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
//        pageControl.style = .imageStyle
//        pageControl.pageIndicatorImage = UIImage(named: "pageNormal")
//        pageControl.currentPageIndicatorImage = UIImage(named: "pageSelected")
        return pageControl
    }
    
}
```
