//
//  RouteDetailController.swift
//  TimeTable
//
//  Created by Hirohisa Suzuki on 2019/10/30.
//  Copyright © 2019 Hirohisa Suzuki. All rights reserved.
//

import UIKit

class RouteDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var route: Route?
    var timeTable: [TimeTable] = [TimeTable]()
    
    @IBOutlet weak var timeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // カスタムセルの追加
        timeTableView.register(UINib(nibName: "TimeTableViewCell", bundle: nil), forCellReuseIdentifier: "timeTable")
        print("画面遷移")
        // userdefaultからデコード処理
        let t1 = TimeTable()
        t1.hour = 5
        t1.minuts = [10,20,30,40,50]
        let t2 = TimeTable()
        t2.hour = 6
        t2.minuts = [15,25,35,45,55]
        self.timeTable.append(t1)
        self.timeTable.append(t2)
    }
    // 行の表示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeTable.count
    }
    // 行の詳細
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeTable", for: indexPath) as!  TimeTableViewCell
        let table = self.timeTable[indexPath.row]
        cell.hour.text = String(table.hour!)
        return cell
    }
    
    // timetableの列追加
    /*private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableCell", for: indexPath) as! TimeTableCollectionViewCell
        return cell
    }*/
}
