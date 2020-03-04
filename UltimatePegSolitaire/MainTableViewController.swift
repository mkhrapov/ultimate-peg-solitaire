//
//  MainTableViewController.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 8/24/19.
//  Copyright © 2019 Maksim Khrapov. All rights reserved.
//

// https://www.ultimatepegsolitaire.com/
// https://github.com/mkhrapov/ultimate-peg-solitaire
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import UIKit

final class MainTableViewController: UITableViewController {
    
    let boardManager = BoardManager.shared
    var selectedIndexPath = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Boards"
        let backItem = UIBarButtonItem()
        backItem.title = "Boards"
        navigationItem.backBarButtonItem = backItem
    }
    
    
    @IBAction func afterSavingNewBoard(_ unwindSegue: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardManager.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardTableViewCell", for: indexPath)

        let boardName = boardManager[indexPath.row].name
        cell.textLabel?.text = boardName
        cell.imageView?.image = GlobalStateManager.shared.getImageByName(boardName)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    // Override to support editing the table view.
    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            boardManager.delete(at: indexPath.row)
            boardManager.persist()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    */
    
    
    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Selected Edit")
            success(true)
        })
        editAction.backgroundColor = .systemGreen
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.boardManager.delete(at: indexPath.row)
            self.boardManager.persist()
            tableView.deleteRows(at: [indexPath], with: .fade)
            success(true)
        })
        deleteAction.backgroundColor = .red
    
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
        performSegue(withIdentifier: "SegueToPlayViewController", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToPlayViewController" {
            if segue.destination is PlayViewController {
                GlobalStateManager.shared.currentPlayingBoardName = boardManager[selectedIndexPath].name
            }
        }
    }
    
    
}
