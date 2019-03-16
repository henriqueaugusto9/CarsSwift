//
//  CarsTableViewController.swift
//  Cars
//
//  Created by Henrique Augusto on 14/03/2019.
//  Copyright © 2019 Henrique Augusto. All rights reserved.

import UIKit
import Alamofire
import Kingfisher

var page = 1

class CarsTableViewController: UITableViewController {
    
    @IBOutlet var carsTable: UITableView!
    
    var baseUrl: String = "http://desafioonline.webmotors.com.br/api/OnlineChallenge/Vehicles?page=\(page)"
    
    var carsInfo : [CarsInfo] = []

    override func viewDidLoad() {
        tableView.rowHeight = 120
        super.viewDidLoad()
        loadCars()
    }
    
    func loadCars(){
        Alamofire.request(baseUrl).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let info = try JSONDecoder().decode([CarsInfo].self, from: data)
                self.carsInfo += info
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.car = carsInfo[tableView.indexPathForSelectedRow!.row]
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carsInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarsCells
        
        let cars = carsInfo[indexPath.row]
        if let url = URL(string: cars.Image){
            cell.imgCar.kf.setImage(with: url)
        }
        cell.nameCar?.text = cars.Model
        cell.priceCar?.text = cars.Make
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == carsInfo.count - 3 && page <= 3 {
            print("Buscando novos carros.")
            page += 1
            loadCars()
        } else {
            print("Acabou os carros...")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class CarsCells: UITableViewCell {
        
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var nameCar: UILabel!
    @IBOutlet weak var priceCar: UILabel!

}
