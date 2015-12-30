//
//  ViewController.swift
//  pockdex-by-quan
//
//  Created by Quan on 15/12/29.
//  Copyright © 2015年 Quan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {

    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var searchBar:UISearchBar!
    var searchMode = false
    
    var pokemon = [Pockmon]()
    var searchPoke = [Pockmon]()
    var musicPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        initAudio()
        
        parsePokemonCSV()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        searchBar.endEditing(true)
//    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchBar.text == nil || searchBar.text == "" {
            searchMode = false
            searchBar.endEditing(true)
        }else {
            searchMode = true
            let lower = searchBar.text!.lowercaseString
            searchPoke = pokemon.filter({ (pock:Pockmon) -> Bool in
                if let _ = pock.name.rangeOfString(lower)
                {
                    return true
                }else {
                    return false
                }
            })
        }
        collectionView.reloadData()
    }
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.stop()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBAction func musicBtnPressed(sender: UIButton!) {
    
        if musicPlayer.playing {
            
            musicPlayer.stop()
            sender.alpha = 0.2
            
        }else {
            
            musicPlayer.play()
            sender.alpha = 1
        }
    
    }

    func parsePokemonCSV() {
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let name = row["identifier"]!
                let pokemonId = Int(row["id"]!)!
                
                let poke = Pockmon(name: name, pockdexId: pokemonId)
                pokemon.append(poke)
            }
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            var poke:Pockmon
            
            if searchMode {
            
                poke = searchPoke[indexPath.row]
                
            }else {
                poke = pokemon[indexPath.row]
            }
                
            cell.configureCell(poke)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pockmon {
                    detailsVC.poke = poke
                }
            }
        }
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var poke:Pockmon!
        
        if searchMode {
            poke = searchPoke[indexPath.row]
        }else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchMode {
            return searchPoke.count
        }else {
            return pokemon.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(110, 110)
    }

}

