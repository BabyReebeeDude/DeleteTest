//
//  MainViewController.swift
//  DeleteTest
//
//  Created by BabyReebeeDude on 2020-02-05.
//  Copyright © 2020 BabyReebeeDude. All rights reserved.
//

import UIKit


final class MainTableViewController: UITableViewController {


    // MARK: - Private Properties

    private var titles: [String] = {
        (0...100).enumerated().map { (offset, _) -> String in
            return String(offset)
        }
    }()

    private lazy var editButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .edit,
                        target: self,
                        action: #selector(toggleEditingState))
    }()

    private lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done,
                        target: self,
                        action: #selector(toggleEditingState))
    }()


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()


        title = "SL Kinda"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = editButton
    }


    // MARK: - Private Methods

    @objc private func toggleEditingState() {
        tableView.isEditing = !tableView.isEditing
        navigationController?.navigationBar.topItem?.rightBarButtonItem = tableView.isEditing ? doneButton : editButton
    }


    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }


    // MARK: -

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            self.titles.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()

            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
}
