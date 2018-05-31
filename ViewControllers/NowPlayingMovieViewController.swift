//
//  NowPlayingMovieViewController.swift
//  MovieApp
//
//  Created by webwerks on 28/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class NowPlayingMovieViewController: UIViewController {

    @IBOutlet var colMovie: UICollectionView!
    
    fileprivate var nowPlayingMovie : INowPlayingMovie = ServiceInjector.sharedInstance.getMovieList()
    
    var currentPage : Int = 0
    var isDataLoading:Bool=false
    var didEndReached:Bool=false
    var currentMethod:String?
    
    var dictMovieList:Movie?{
        didSet{
          colMovie.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionview()
        currentMethod = APIMethodConstants.kNowPlaying
        if (Reachability.isConnectedToNetwork()){
            fetchDataforMovie(pageNo: 1, methodName: currentMethod!)
        }else{
            self.showAlert(string: Messages.kNoInternet)
        }
    }
    
    func setupCollectionview(){
       colMovie.delegate = self
       colMovie.dataSource = self
    }
    
    func fetchDataforMovie(pageNo:Int,methodName:String){
        AppDelegate.showHud()
        currentPage += 1
        nowPlayingMovie.getNowPlayingMoview(_methodName: methodName, _pageNo: currentPage) { (response) in
            AppDelegate.stopHud()
            switch(response)
            {
            case .success:
                if(self.isDataLoading){
                    let responsevalue = response.value as? Movie
                    for data in (responsevalue?.results)!{
                        self.dictMovieList?.results?.append(data)
                    }
                    self.colMovie.reloadData()
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
               fetchDataforMovie(pageNo: currentPage, methodName:currentMethod!)
            }else{
                self.showAlert(string: Messages.kNoInternet)
            }
        }
    }

    class func instantiateFromStoryboard() -> NowPlayingMovieViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! NowPlayingMovieViewController
    }
    
    @IBAction func onClickOfFilter(_ sender: UIButton) {
        let vc = FilterViewController.instantiateFromStoryboard()
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
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

extension NowPlayingMovieViewController :FilterViewDelegate{
    func selectFilterfor(filter: String, View: FilterViewController) {
        View.dismiss(animated: false, completion: nil)
        currentPage = 0
        currentMethod = filter
        fetchDataforMovie(pageNo: currentPage, methodName:currentMethod!)
    }
}
extension NowPlayingMovieViewController :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let arrSong = dictMovieList?.results{
            return arrSong.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewConst.knowPlayingCell, for: indexPath) as? NowPlayingCollectionViewCell {
            collCell.cellData = dictMovieList?.results![indexPath.row]
           return collCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let vc = DeatilViewController.instantiateFromStoryboard()
        vc.movieID = dictMovieList?.results![indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: false)
}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
       
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = frameSize.width/2.0 - 10
        collectionViewSize.height = 200.0
        return collectionViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
       
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((colMovie.contentOffset.y + colMovie.frame.size.height) >= colMovie.contentSize.height)
        {
            if !isDataLoading{
                isDataLoading = true
                loadMoreItemsForList()
                
            }
        }
    }
}
