//
//  TimeTableViewCell.swift
//  TodoList
//
//  Created by Hirohisa Suzuki on 2019/10/31.
//  Copyright © 2019 Hirohisa Suzuki. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let nib = UINib(nibName: "TimeTableCollectionViewCell", bundle: nil)
//        timeTableCollectionView.register(nib, forCellWithReuseIdentifier: "TimeTableCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
    
    @IBOutlet weak var hour: UILabel!
    
    @IBOutlet weak var timeTableCollectionView: UICollectionView!
}
