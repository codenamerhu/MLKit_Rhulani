//
//  ViewController.swift
//  MLKit_Rhulani
//
//  Created by Rhulani Ndhlovu on 2021/09/22.
//

import UIKit

class ViewController: UIViewController {
    

    let viewName = ["Text Recognition", "Barcode Scanner", "Face Detection"]
    let segueId = ["textSegue","barcodeSegue","faceSegue"]
    
    @IBOutlet weak var moduleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moduleTableView.delegate = self
        moduleTableView.dataSource = self
        moduleTableView.tableFooterView = UIView()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewName[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueId[indexPath.row], sender: self)
    }
}


