//
//  DeatilViewController.swift
//  MovieApp
//
//  Created by webwerks on 28/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit
import Foundation
import SafariServices
import SDWebImage

class DeatilViewController: UIViewController {

  
    @IBOutlet var imgPoster: UIImageView!
    @IBOutlet var collMovie: UICollectionView!
    @IBOutlet var lblOverView: UILabel!
    @IBOutlet var lblReleaseDt: UILabel!
    @IBOutlet var lblgener: UILabel!
    @IBOutlet var lblLang: UILabel!
    @IBOutlet var lblTitle: UILabel!
    
    fileprivate var movieDeatilService : IGetMovieDetails = ServiceInjector.sharedInstance.getMovieDatils()
    fileprivate var similarMovieSErvice : ISimilarMovies = ServiceInjector.sharedInstance.getSimilarMovie()
    
    var movieID:Int?{
        didSet{
          
        }
    }
    var movieDeatilModel:MovieDeatilModel?{
        didSet{
            setupView()
        }
    }
    
    var similarMovie:SearchModel?{
        didSet{
            collMovie.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collMovie.delegate = self
        collMovie.dataSource = self
        if(Reachability.isConnectedToNetwork()){
        fetchMovieDeatilsforId(id: movieID!)
        fetchSimilarMovie(id: movieID!)
        }else{
         self.showAlert(string: Messages.kNoInternet)
        }
    }
    
    class func instantiateFromStoryboard() -> DeatilViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! DeatilViewController
    }
    
    func fetchMovieDeatilsforId(id:Int){
        AppDelegate.showHud()
        let methodName = "\(APIMethodConstants.kMovieDetail)\(id)"
            movieDeatilService.getMovieDeatilForMovieID(_methodName: methodName) { (response) in
                AppDelegate.stopHud()
                switch(response){
                case .success:
                self.movieDeatilModel = response.value as? MovieDeatilModel
                break
                case .failure:
                break
                }
        }
    }
    func fetchSimilarMovie(id:Int){
        AppDelegate.showHud()
        let methodNAme = "\(APIMethodConstants.kMovieDetail)\(id)\(APIMethodConstants.kSimilar)"
        similarMovieSErvice.getSimilarMoviesFor(_methodNAme: methodNAme,page:1) { (response) in
            AppDelegate.stopHud()
            switch(response){
            case .success:
                self.similarMovie = response.value as? SearchModel
                break
            case .failure:
                break
            }
    }
    }
    func setupView(){
        lblTitle.text = movieDeatilModel?.title
        lblLang.text = movieDeatilModel?.original_language
        lblgener.text = "comedy"
        lblReleaseDt.text = movieDeatilModel?.release_date
        lblOverView.text = movieDeatilModel?.overview
        if(Reachability.isConnectedToNetwork()){
            if let imageName = movieDeatilModel?.poster_path {
                let imagepath = "\(APIConst.kBannerURL)\(imageName)"
                imgPoster.sd_setImage(with: URL(string: imagepath), placeholderImage: UIImage(named: "backGround"))

            }
        }
        
        
    }
    
    
    @IBAction func OnclickOFMore(_ sender: UIButton) {
        if(Reachability.isConnectedToNetwork()){
        if let homepageurl = movieDeatilModel?.homepage{
            let url = URL(string: homepageurl)
            let controller = SFSafariViewController(url: url!)
            self.present(controller, animated: true, completion: nil)
        }
        }else{
            self.showAlert(string: Messages.kNoInternet)
        }
       
        
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


extension DeatilViewController:UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if let arrMovie = similarMovie?.results{
            return arrMovie.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewConst.ksimilarMovieCell, for: indexPath) as? SimillarMovieCollectionViewCell {
           // collCell.lbllanguage.text = "test"
            
            collCell.data = similarMovie?.results![indexPath.row]
            return collCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = 200.0
        collectionViewSize.height = 200.0
        return collectionViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
    }
}
