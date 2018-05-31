//
//  CommingSoonMoviewViewController.swift
//  MovieApp
//
//  Created by webwerks on 28/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class CommingSoonMoviewViewController: UIViewController {

    
    @IBOutlet var tblComingSoonMovie: UITableView!
    
    var currentPage : Int = 0
    var isDataLoading:Bool=false
    var pageNo:Int=0
    var didEndReached:Bool=false
    fileprivate var nowPlayingMovie : INowPlayingMovie = ServiceInjector.sharedInstance.getMovieList()
    
    var dictMovieList:Movie?{
        didSet{
          tblComingSoonMovie.reloadData()
         
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTblView()
        if(Reachability.isConnectedToNetwork()){
        fetchDataforComingsoon(pageNo: currentPage)
        }else{
            self.showAlert(string: Messages.kNoInternet)
        }

        // Do any additional setup after loading the view.
    }
    func setupTblView(){
        tblComingSoonMovie.delegate = self
        tblComingSoonMovie.dataSource = self
    }
    
    func fetchDataforComingsoon(pageNo:Int){
        AppDelegate.showHud()
         currentPage += 1
        nowPlayingMovie.getNowPlayingMoview(_methodName: APIMethodConstants.KMovieUpcoming, _pageNo: currentPage) { (response) in
            AppDelegate.stopHud()
            switch(response)
            {
            case .success:
               
                if(self.isDataLoading){
                    let responsevalue = response.value as? Movie
                    for data in (responsevalue?.results)!{
                      self.dictMovieList?.results?.append(data)
                    }
                    self.tblComingSoonMovie.reloadData()
                }else{
                self.dictMovieList = response.value as? Movie
                }
                break
            case.failure:
                // show no result found
                break
            }
        }
    }
    func loadMoreItemsForList(){
        if(currentPage <= (dictMovieList?.total_pages)!){
            if(Reachability.isConnectedToNetwork()){
                fetchDataforComingsoon(pageNo: currentPage)
            }else{
                self.showAlert(string: Messages.kNoInternet)
            }
        }
    }
    class func instantiateFromStoryboard() -> CommingSoonMoviewViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! CommingSoonMoviewViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension CommingSoonMoviewViewController : UITableViewDelegate,UITableViewDataSource ,UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arrSong = dictMovieList?.results{
            return arrSong.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: ViewConst.kComingSoonCell, for: indexPath) as? ComingSoonTableViewCell {
            cell.data = dictMovieList?.results![indexPath.row]
             return cell
        }
       
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DeatilViewController.instantiateFromStoryboard()
        vc.movieID = dictMovieList?.results![indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: false)
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
//            isLoadingList = true
//            scrollView.isScrollEnabled = false
//            loadMoreItemsForList()
//        }
//    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tblComingSoonMovie.contentOffset.y + tblComingSoonMovie.frame.size.height) >= tblComingSoonMovie.contentSize.height)
        {
            if !isDataLoading{
                isDataLoading = true
                 loadMoreItemsForList()
                
            }
        }
    }
}
