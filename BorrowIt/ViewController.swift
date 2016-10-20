//
//  ViewController.swift
//  BorrowIt
//
//  Created by EMMANUEL J ZAFRA on 10/19/16.
//  Copyright © 2016 EMMANUEL J ZAFRA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
        items = try context.fetch(Item.fetchRequest())
        tableView.reloadData()
        } catch {
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = items[indexPath.row]
        cell.textLabel?.text = item.who
        cell.imageView?.image = UIImage(data: item.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        performSegue(withIdentifier: "itemSegue", sender: item)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! BorrowViewController
        nextVC.item = sender as? Item
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = items[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(item)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                items = try context.fetch(Item.fetchRequest())
                tableView.reloadData()
            } catch {}
        }
        
    }

    
}

