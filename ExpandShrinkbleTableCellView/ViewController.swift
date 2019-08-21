//
//  ViewController.swift
//  ExpandShrinkbleTableCellView
//
//  Created by shankars on 8/21/19.
//  Copyright © 2019 shankars. All rights reserved.
//

import UIKit

struct CellModel {
    var opened : Bool
    var title : String
    var rows :[String]
}

// This is required for custom object comparison
extension CellModel:Equatable {
    static func ==(lhs:CellModel, rhs:CellModel) -> Bool { // Implement Equatable
        return lhs.title == rhs.title
    }
}

class ExpandShrinkTableViewController: UITableViewController {
    var tableViewData : [CellModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewData = [CellModel(opened: false, title: "Title1", rows: ["Cell1","Cell2","Cell3"]),
                         CellModel(opened: false, title: "Title2", rows: ["Cell4","Cell5","Cell6"]),
                         CellModel(opened: false, title: "Title3", rows: ["Cell8","Cell7","Cell9"])]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened {
            return tableViewData[section].rows.count + 1
        }
        else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let openedGroup = tableViewData[indexPath.section]
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = openedGroup.title
        } else {
            cell.textLabel?.text = openedGroup.rows[indexPath.row-1]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Case:1 expand and shrink section on click of title
        //        if tableViewData[indexPath.section].opened == true {
        //            tableViewData[indexPath.section].opened = false
        //            let indexSet = IndexSet(integer: indexPath.section)
        //            tableView.reloadSections(indexSet, with: UITableView.RowAnimation.fade)
        //
        //        } else {
        //            tableViewData[indexPath.section].opened = true
        //            let indexSet = IndexSet(integer: indexPath.section)
        //            tableView.reloadSections(indexSet, with: UITableView.RowAnimation.middle)
        //        }
        
        // Case:2 shrink expanded section before expand other section on the click title
        
        let alreadyOpenSection = tableViewData.filter{$0.opened == true}
        if let sectionData = alreadyOpenSection.first, tableViewData.contains(sectionData) {
            if let index =  tableViewData.firstIndex(of: sectionData) {
                tableViewData[index].opened = false
                let indexSet = IndexSet(integer: index)
                tableView.reloadSections(indexSet, with: UITableView.RowAnimation.fade)
                if index != indexPath.section {
                    tableViewData[indexPath.section].opened = true
                    let indexSet = IndexSet(integer: indexPath.section)
                    tableView.reloadSections(indexSet, with: UITableView.RowAnimation.fade)
                }
            }
            
        } else {
            tableViewData[indexPath.section].opened = true
            let indexSet = IndexSet(integer: indexPath.section)
            tableView.reloadSections(indexSet, with: UITableView.RowAnimation.fade)
        }
    }
    
}


