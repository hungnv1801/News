//
//  NewsTableViewCell.swift
//  NEWS
//
//  Created by Nguyen Trung on 15/11/2020.
//  Copyright © 2020 Nguyen Hung. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var readMoreView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readMoreView.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func readMoreButton(_ sender: UIButton) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vcWebView = mainStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vcWebView.link = "https://dantri.com.vn/"
        print(vcWebView.link)
    }
}
