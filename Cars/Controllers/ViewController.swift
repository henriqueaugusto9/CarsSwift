//
//  ViewController.swift
//  Cars
//
//  Created by Henrique Augusto on 14/03/2019.
//  Copyright © 2019 Henrique Augusto. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carImg: UIImageView!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carVersion: UILabel!
    @IBOutlet weak var carKM: UILabel!
    @IBOutlet weak var carFab: UILabel!
    @IBOutlet weak var carModel: UILabel!
    
    var car: CarsInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carName.text = car.Model
        if let url = URL(string: car.Image){
            self.carImg.kf.setImage(with: url)
        } else { self.carImg.image = nil}
        self.carPrice.text = car.Price
        self.carVersion.text = car.Version
        self.carKM.text = String(car.KM)
        self.carFab.text = String(car.YearFab)
        self.carModel.text = String(car.YearModel)
        
    }
}
