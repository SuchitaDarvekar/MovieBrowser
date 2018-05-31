//
//  SearchViewController.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var imgBackground: UIImageView!
    @IBOutlet var tblSearch: UITableView!
     var searchBar: UISearchBar!
    
    var searchActive : Bool = false
    var arrSearchResult:SearchModel?{
        didSet{
            tblSearch.reloadData()
        }
    }
    
    fileprivate var searchListService : ISearchMovie = ServiceInjector.sharedInstance.searchMovie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTblView()
        setupSearchBar()
       // setupData(searchStr: "Marvel")
        
    }

    func setupData(searchStr:String){
        if(Reachability.isConnectedToNetwork()){
            AppDelegate.showHud()
    searchListService.searchMovieByQuery(_queryString: searchStr, _page: 1, _methodName: APIMethodConstants.kSearchMovie) { (response) in
        AppDelegate.stopHud()
      switch(response)
      {
      case .success:
        self.arrSearchResult = response.value as? SearchModel
        break
      case.failure:
        // show no result found
        break
       }
      }
        }else{
            self.showAlert(string: Messages.kNoInternet)
        }
    }
    
    func setupSearchBar(){
        searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Movie"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func setupTblView(){
        tblSearch.delegate = self
        tblSearch.dataSource = self
        tblSearch.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if let arrSong = arrSearchResult?.results{
            return arrSong.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tblCell = tableView.dequeueReusableCell(withIdentifier: ViewConst.kSearchTblCell, for: indexPath) as? SearchTableViewCell{
            tblCell.cellData = arrSearchResult?.results![indexPath.row]
            return tblCell

        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension SearchViewController :UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
         searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        arrSearchResult = nil
        searchActive = false
        searchBar.resignFirstResponder()
       
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if(!(searchText.isEmpty)){
        setupData(searchStr: searchText)
       }else{
         arrSearchResult = nil
        }
    }
   
        
}
