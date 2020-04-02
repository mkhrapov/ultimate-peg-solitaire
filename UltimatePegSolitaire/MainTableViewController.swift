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
import MobileCoreServices

final class MainTableViewController: UITableViewController, UITableViewDropDelegate, UITableViewDragDelegate {
    
    let boardManager = BoardManager.shared
    var selectedIndexPath = 0
    var previousMode = "light"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Boards"
        let backItem = UIBarButtonItem()
        backItem.title = "Boards"
        navigationItem.backBarButtonItem = backItem
        
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
    }
    
    
    @IBAction func afterSavingNewBoard(_ unwindSegue: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var currentMode = "light"
        
        if GlobalStateManager.shared.needToReloadData {
            GlobalStateManager.shared.needToReloadData = false
            self.tableView.reloadData()
            self.tableView.setNeedsDisplay()
        }
        else {
            if #available(iOS 13.0, *) {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    currentMode = "dark"
                }
                else {
                    currentMode = "light"
                }
            }
            
            if previousMode != currentMode {
                previousMode = currentMode
                self.tableView.reloadData()
                self.tableView.setNeedsDisplay()
            }
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }

        // does not work on simulator
        // probably will not work if mode changes automatically due to programmed timed change
        self.tableView.reloadData()
        self.tableView.setNeedsDisplay()
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
        cell.imageView?.image = IconManager.shared.getImageByName(boardName)
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
            success(true)
            self.selectedIndexPath = indexPath.row
            self.performSegue(withIdentifier: "SegueToEditNameViewController", sender: self)
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
        boardManager.move(fromIndexPath.row, to.row)
        boardManager.persist()
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
        else if segue.identifier == "SegueToEditNameViewController" {
            if segue.destination is EditNameViewController {
                GlobalStateManager.shared.currentPlayingBoardName = boardManager[selectedIndexPath].name
            }
        }
    }
    
    
    // MARK: - Drag
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let placeholder = "hello drag and drop" as NSString
        let itemProvider = NSItemProvider(object: placeholder)
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    
    // MARK: - Drop
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }
}
