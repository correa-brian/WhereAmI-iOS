//
//  WACollectionViewCell.swift
//  WhereAmI
//
//  Created by Brian Correa on 4/26/16.
//  Copyright © 2016 milkshake-systems. All rights reserved.
//

import UIKit

class WACollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.imageView.backgroundColor = UIColor.lightGrayColor()
        self.contentView.addSubview(self.imageView)
        
//        let colors = [
//            UIColor.greenColor(),
//            UIColor.redColor(),
//            UIColor.yellowColor(),
//            UIColor.blueColor(),
//            UIColor.orangeColor()
//        ]
        
//        var i = arc4random()
//        i = i % UInt32(colors.count)
//        let color = colors[Int(i)]
//        
//        self.backgroundColor = color
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
}
