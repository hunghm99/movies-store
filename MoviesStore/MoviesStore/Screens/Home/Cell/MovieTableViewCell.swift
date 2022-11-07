//
//  MovieTableViewCell.swift
//  MoviesStore
//
//  Created by Hung Hoang on 8/30/22.
//

import UIKit
import MBCircularProgressBar

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var voteAverageView: MBCircularProgressBarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.voteAverageView.layer.cornerRadius = voteAverageView.bounds.height/2

    }
    
}
