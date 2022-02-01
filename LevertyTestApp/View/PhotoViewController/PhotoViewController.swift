//
//  PhotoViewController.swift
//  LevertyTestApp
//
//  Created by Purushottam Padhya on 26/1/22.
//

import UIKit

class PhotoViewController: UIViewController{
    
    var viewModel: PhotoViewModel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photoTableView: UITableView!
    var refreshControl = UIRefreshControl()
    var isLoading = false
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos"
        viewModel = PhotoViewModel()
        viewModel.getPhotos()
        setupView()
        apiResponseHandler()
    }
    
    func setupView(){
        searchBar.tintColor = .appColor
        searchBar.delegate = self
        
        refreshControl.addRefreshControl(tableView: photoTableView, message: "Loading...")
        refreshControl.tintColor  = UIColor.red
        photoTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        photoTableView.delegate = self
        photoTableView.dataSource = self
    }
    @objc func refresh(_ sender: Any){
        isLoading = true
        viewModel.getPhotos()
    }
    
    func apiResponseHandler(){
        viewModel.onSuccess = {[weak self] in
            guard let _self = self else {return}
            DispatchQueue.main.async {
                _self.isLoading = false
                _self.refreshControl.endRefreshing()
                _self.photoTableView.reloadData()

            }
        }
        viewModel.onDelete = {[weak self] indexPath in
            guard let _self = self else {return}
            _self.photoTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension PhotoViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return viewModel.searchPhoto.count
        }
        return viewModel.photo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
        if isSearching{
            let searchData = viewModel.searchPhoto[indexPath.row]
            cell.setupCell(photo: searchData)
        }
        else{
            let data = viewModel.photo[indexPath.row]
            cell.setupCell(photo: data)
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item is clicked")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            viewModel.deleteRowPhoto(at: indexPath)
        }
    }
}

extension PhotoViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        if let searchText = searchBar.text{
            viewModel.getSearchPhoto(searchText: searchText)
            if viewModel.searchPhoto.count > 0 {
                isSearching = true
                self.photoTableView.reloadData()
            }
            else{
                
                self.showAlertView(title: "Search Result", msg: "Could not found any data for your search key.")
            }
        }
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text{
            viewModel.getSearchPhoto(searchText: searchText)
            if viewModel.searchPhoto.count > 0 {
                isSearching = true
                self.photoTableView.reloadData()
            }
            else{
                
                self.showAlertView(title: "Search Result", msg: "Could not found any data for your search key.")
            }
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.photoTableView.reloadData()
    }
}
