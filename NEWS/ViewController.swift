//
//  ViewController.swift
//  NEWS
//
//  Created by Nguyen Trung on 15/11/2020.
//  Copyright © 2020 Nguyen Hung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
    
    //MARK: -Properties
    @IBOutlet weak var tableView: UITableView!
    var articles = [Article]()
    private let baseURL = "https://newsapi.org/v2/everything?q=bitcoin&from=2020-10-17&sortBy=publishedAt&apiKey="
    private let apiKey = "59d1b307c52c4dd4bd7e6a2d4f3f96ac"
    
    //MARK: -Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    func getData(){
        let url = baseURL + apiKey
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { [weak self] (response) in
            guard let strongSelft = self else {return}
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let data = ResultAPIModel(json: json) {
                    strongSelft.articles = data.articles ?? []
                    DispatchQueue.main.async {
                        strongSelft.title = "Articles count: \(self!.articles.count)"
                        strongSelft.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

    //MARK: -Extention: TableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.sourceLabel.text = article.source?.name
        
        //Lấy ảnh theo url
        let url = URL(string: article.urlToImage!)
        cell.imgView.kf.setImage(with: url)
//        if let url = URL(string: article.urlToImage!) {
//            cell.imgView.kf.setImage(with: url, placeholder: UIImage(named: "grab"))
//        }
        
        //Conver String to Date
        let dateString = article.publishedAt!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateValue = formatter.date(from: dateString)!
        
        formatter.dateFormat = "MMM dd, yyyy HH:mm a"
        let dateNewString = formatter.string(from: dateValue)
        cell.publishedLabel.text = dateNewString
        tableView.separatorColor = UIColor.red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

