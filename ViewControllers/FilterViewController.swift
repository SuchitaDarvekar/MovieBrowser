//
//  FilterViewController.swift
//  MovieApp
//
//  Created by webwerks on 29/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

protocol FilterViewDelegate:class {
    func selectFilterfor(filter:String,View:FilterViewController)
}
class FilterViewController: UIViewController {
   
    
    @IBOutlet var btnApply: UIButton!
    @IBOutlet var tblFilter: UITableView!
    var arrFilter:[Filter]=[]{
        didSet{
            tblFilter.reloadData()
        }
    }
    weak var delegate: FilterViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFilter.delegate = self
        tblFilter.dataSource = self
        tblFilter.tableFooterView = UIView()
        setupData()

        // Do any additional setup after loading the view.
    }
    func setupData(){
        let popData = Filter(_image: "popular", _title: "Popularity", _method: APIMethodConstants.kMoviePopular)
        let highratedData = Filter(_image: "highRated", _title: "High Rated", _method: APIMethodConstants.kMovieToprated)
        arrFilter = [popData,highratedData]
        
    }
    class func instantiateFromStoryboard() -> FilterViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! FilterViewController
    }
    
    @IBAction func onClickOfApply(_ sender: UIButton) {
        if let filterName = arrFilter[sender.tag].method  {
           delegate?.selectFilterfor(filter: filterName,View: self)
        }
    }
    @IBAction func onClickOfReset(_ sender: UIButton) {
        delegate?.selectFilterfor(filter: APIMethodConstants.kNowPlaying,View: self)
    }
    @IBAction func onClickOfCancel(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension FilterViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tblcell = tableView.dequeueReusableCell(withIdentifier: ViewConst.kfilterTblCell, for: indexPath) as? FilterTableViewCell {
            tblcell.imgView?.image = UIImage(named:arrFilter[indexPath.row].image!)
            tblcell.lblTitle.text = arrFilter[indexPath.row].title
            return tblcell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrFilter[indexPath.row].method!)
        if let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell {
            cell.imgCheck.image = UIImage(named: "checked")
            btnApply.tag = indexPath.row
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell {
            cell.imgCheck.image = UIImage(named: "blank")
            
        }
    }
}
