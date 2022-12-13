//
//  ViewController.swift
//  ZarAtmaOyunu
//
//  Created by Muhammed Gül on 1.11.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblOyuncu1Skoru: UILabel!
    @IBOutlet weak var lblOyuncu2Skoru: UILabel!
    @IBOutlet weak var lblOyuncu1Puan: UILabel!
    @IBOutlet weak var lblOyuncu2Puan: UILabel!
    @IBOutlet weak var lblOyuncu1Durum: UIImageView!
    @IBOutlet weak var lblOyuncu2Durum: UIImageView!
    @IBOutlet weak var imgZar1: UIImageView!
    @IBOutlet weak var imgZar2: UIImageView!
    @IBOutlet weak var lblSetSonucu: UILabel!
    
    var oyuncuPuanlari = (birinciOyuncuPuani : 0 , ikinciOyuncuPuani : 0)
    var oyuncuSkorlari = (birinciOyuncuSkoru : 0, ikinciOyunuSkoru : 0)
    var oyuncuSira : Int = 1
    
    var maxSetSayisi : Int = 5
    var suankiSetSayisi : Int = 1
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if let arkaPlan = UIImage(named: "arkaPlan"){
            self.view.backgroundColor = UIColor(patternImage: arkaPlan)
        }
    }
    
     
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if suankiSetSayisi > maxSetSayisi {
            return
        }
     zarDegerleriniUret()
    }
    func setSonucu(zar1 : Int, zar2 : Int){
        if oyuncuSira == 1 {
            oyuncuPuanlari.birinciOyuncuPuani = zar1 + zar2
            lblOyuncu1Puan.text = String(oyuncuPuanlari.birinciOyuncuPuani)
            lblOyuncu1Durum.image = UIImage(named: "bekle")
            lblOyuncu2Durum.image = UIImage(named: "onay")
            lblSetSonucu.text = "Sıra 2. Oyuncuda"
            oyuncuSira = 2
            lblOyuncu2Puan.text = "O"
        } else {
            oyuncuPuanlari.ikinciOyuncuPuani = zar1 + zar2
            lblOyuncu2Puan.text = String(oyuncuPuanlari.ikinciOyuncuPuani)
            lblOyuncu1Durum.image = UIImage(named: "onay")
            lblOyuncu2Durum.image = UIImage(named: "bekle")
            oyuncuSira = 1
            
            //seti bitirme işlemleri
            if oyuncuPuanlari.birinciOyuncuPuani > oyuncuPuanlari.ikinciOyuncuPuani {
                //1. oyuncu oyunu kazandı
                oyuncuSkorlari.birinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(suankiSetSayisi). Seti 1. Oyuncu Kazandı"
                suankiSetSayisi += 1
                lblOyuncu1Skoru.text = String(oyuncuSkorlari.birinciOyuncuSkoru)
            } else if oyuncuPuanlari.ikinciOyuncuPuani > oyuncuPuanlari.birinciOyuncuPuani {
                oyuncuSkorlari.ikinciOyunuSkoru += 1
                lblSetSonucu.text = "\(suankiSetSayisi). Seti 2. Oyuncu Kazandı"
                suankiSetSayisi += 1
                lblOyuncu2Skoru.text = String(oyuncuSkorlari.ikinciOyunuSkoru)
            } else {
                //oyun beraber kaldı
                //set sayısı değiştirilmemeli
                
                lblSetSonucu.text = "\(suankiSetSayisi). Set Berabere Sona Erdi."
            }
            
            oyuncuPuanlari.birinciOyuncuPuani = 0
            oyuncuPuanlari.ikinciOyuncuPuani = 0
        }
    }
    
    func zarDegerleriniUret(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            let zar1 = arc4random_uniform(6) + 1
            let zar2 = arc4random_uniform(6) + 1
            
            self.imgZar1.image = UIImage(named: String(zar1))
            self.imgZar2.image = UIImage(named: String(zar2))
            
            self.setSonucu(zar1: Int(zar1), zar2: Int(zar2))
            
            if self.suankiSetSayisi > self.maxSetSayisi {
                if self.oyuncuSkorlari.birinciOyuncuSkoru > self.oyuncuSkorlari.ikinciOyunuSkoru {
                    self.lblSetSonucu.text = "Oyununun Galibi 1. Oyuncu"
                } else {
                    self.lblSetSonucu.text = "Oyununun Galibi 2. Oyuncu"
                }
            }
        }
        
        lblSetSonucu.text = "\(oyuncuSira). Oyuncu için Zar Atılıyor"
        imgZar1.image = UIImage(named: "bilinmeyenZar")
        imgZar2.image = UIImage(named: "bilinmeyenZar")
        
    }
}

