//
//  BookListController.swift
//  Book
//
//  Created by Hanriver Macbook on 08/06/24.
//

import UIKit

class BookListController: UIViewController {

    @IBOutlet weak var header: UIView!
    @IBOutlet weak var tableViewBook: UITableView!
    let viewModel = BookListViewModel()
    var refreshControl = UIRefreshControl()
    var page = 1
    let limit = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.addBottomBorderWithColor(color: UIColor.lightGray, width: 1.5)
        setupTableView()
        viewModel.getBookList(page: page, limit: limit) { result in
            switch result {
            case .success(let books):
                print(books)
                DispatchQueue.main.async {
                    self.tableViewBook.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    //MARK: - Utility Function -
    
    //MARK: Set up Table view
    func setupTableView() {
        tableViewBook.rowHeight = UITableView.automaticDimension
        tableViewBook.estimatedRowHeight = 100
        tableViewBook.dataSource = self
        tableViewBook.delegate = self
        tableViewBook.prefetchDataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableViewBook.refreshControl = refreshControl
    }

    //MARK: Pull to Refresh data
    @objc func refreshData() {
        // Reset current page
        page = 1
        viewModel.getBookList(page: page, limit: limit) { result in
            switch result {
            case .success(let books):
                print(books)
                DispatchQueue.main.async {
                    self.tableViewBook.reloadData()
                    self.refreshControl.endRefreshing()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate function
extension BookListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.datasource = viewModel.bookList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let selectedItem = viewModel.bookList[indexPath.row]
        let alertController = UIAlertController(title: "", message: selectedItem.url, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.bookList.count > 0 {
            if indexPath.row == viewModel.bookList.count - 5 {
                page += 1
                viewModel.getBookList(page: page, limit: limit) { result in
                    switch result {
                    case .success(let books):
                        print(books)
                        DispatchQueue.main.async {
                            self.tableViewBook.reloadData()
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
       
    }
}

//MARK: - UITableViewDataSourcePrefetching -
extension BookListController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("prefetchRowsAt : \(indexPaths)")
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
     print("cancelPrefetchingForRowsAt \(indexPaths)")
    }
}
