//
//  ViewController.swift
//  TimeTable
//
//  Created by Hirohisa Suzuki on 2019/10/30.
//  Copyright © 2019 Hirohisa Suzuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var routes = [Route]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // userdataの読み込み
        let storedRoutes = UserDefaults.standard.object(forKey: "routes") as? Data
        //objectとして取得し、Data型にダウンキャストする
        if storedRoutes != nil {
            do {
                let unarchiveRoutes = try NSKeyedUnarchiver.unarchivedObject(
                    ofClasses: [NSArray.self, Route.self] // 使われているクラスを列挙する。今回は配列とTodoクラス。
                    , from: storedRoutes!
                ) as? [Route] // Routeの配列にダウンキャスト
                if unarchiveRoutes != nil {
                    routes.append(contentsOf: unarchiveRoutes!)
                }
            } catch {
                // error
            }
        }
        

    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        // アラートコントローラの作成
        let alertController = UIAlertController(title: "経路の追加", message: "経路を追加してください。",preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: nil)
        
        // OK イベントの作成
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            if let textField = alertController.textFields?.first{
                
                // routeの作成
                let route = Route()
                route.name = textField.text!
                self.routes.insert(route, at: 0)
                
                // 行追加の通知
                self.tableView.insertRows(at:[ IndexPath(row:0, section:0)],with: UITableView.RowAnimation.right)
                
                // UserDataへの保存
                self.serializeTodoData()
            }
        }
        alertController.addAction(okAction)

         
        // Cancelボタン作成
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelButton)
        
        // ダイアログの表示（アラートコントローラを足す）
        present(alertController, animated: true, completion: nil)
    }
    // 行の表示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }

    // 行の詳細
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath)
        let route = routes[indexPath.row]
        cell.textLabel?.text = route.name
        if route.isDefault{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }else{
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        return cell
    }
    
    // 行をタップしたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let todo = todoList[indexPath.row]
        if todo.isDefault{
            todo.isDefault = false
        }else{
            todo.isDefault = true
        }
        // 行の状態変更
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        
        // 行の状態を保存
        serializeTodoData()*/
    }
    
    // 詳細表示時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let route = routes[indexPath.row]
            let cont = segue.destination as! RouteDetailController
            cont.route = Route()
            cont.route?.name = route.name
        }
    }
    
    // 行編集を可能にする
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 行削除する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            routes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            //保存
            serializeTodoData()
        }
    }
    // Data型にシリアライズし、UserDefaultに保存する
    func serializeTodoData(){

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self.routes, requiringSecureCoding: true)
                UserDefaults.standard.set(data, forKey: "routes")
                UserDefaults.standard.synchronize()
        } catch {
                // error
        }
    }

}

