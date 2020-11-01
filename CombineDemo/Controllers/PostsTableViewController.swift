//
//  PostsTableViewController.swift
//  CombineDemo
//
//  Created by Kunal Tyagi on 26/10/20.
//

import UIKit
import Combine

class PostsTableViewController: UITableViewController {
    
    private var webService = WebService()
    private var posts = [Post]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        cancellable = webService.getPosts()
            .catch { _ in Just(self.posts) }
            .assign(to: \.posts, on: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") else { return UITableViewCell() }
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].body
        return cell
    }

}
