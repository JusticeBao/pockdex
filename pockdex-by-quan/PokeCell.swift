//
//  PokeCell.swift
//  pockdex-by-quan
//
//  Created by Quan on 15/12/29.
//  Copyright © 2015年 Quan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    
    var pockmon:Pockmon!
    
    func configureCell(pockmon:Pockmon){
        self.pockmon = pockmon
        
        nameLbl.text = self.pockmon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pockmon.pockdexId)")
    }
    
}
