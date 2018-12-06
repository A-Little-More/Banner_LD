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

