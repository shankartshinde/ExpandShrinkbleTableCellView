# ExpandShrinkbleTableCellView
This simple example demonstrate for expand and shrink table cell

We have two option

##Option-1 - On click header you can expand same section as well other section too

                if tableViewData[indexPath.section].opened == true {
                    tableViewData[indexPath.section].opened = false
                    let indexSet = IndexSet(integer: indexPath.section)
                    tableView.reloadSections(indexSet, with: UITableView.RowAnimation.fade)
        
                } else {
                    tableViewData[indexPath.section].opened = true
                    let indexSet = IndexSet(integer: indexPath.section)
                    tableView.reloadSections(indexSet, with: UITableView.RowAnimation.middle)
                }


## Option-2 On click title expand table cell, if already option section then close(shrink) that section and expand clicked section
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
