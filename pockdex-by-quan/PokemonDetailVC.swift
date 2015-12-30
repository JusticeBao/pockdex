//
//  PokemonDetailVC.swift
//  pockdex-by-quan
//
//  Created by Quan on 15/12/30.
//  Copyright © 2015年 Quan. All rights reserved.
//

import UIKit


class PokemonDetailVC: UIViewController {

    var poke:Pockmon!
    
    @IBOutlet weak var nameLbl:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = poke.name
    }
    
}
