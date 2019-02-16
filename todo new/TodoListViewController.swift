//
//  ViewController.swift
//  todo new
//
//  Created by 松田勇樹 on 2018/10/27.
//  Copyright © 2018 松田勇樹. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    class Item {
        var title : String
        var done: Bool = false
        
        init(title: String) {
            self.title = title
        }
    }
    // この配列に作ったアイテムを追加していく
    var itemArray: [Item] = []
    var saveArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NaviBarのタイトルを大きく表示させる
        navigationController?.navigationBar.prefersLargeTitles = true
        // あらかじめ3つアイテムを作っておく
        if userDefaults.array(forKey: "saveData") != nil{
            saveArray = userDefaults.array(forKey: "saveData") as! [String]
            print("test")
            
            
      }
        // 配列に追加
        var i:Int = 0
        for _ in saveArray{
            itemArray.append(Item(title: saveArray[i]))//saveArrayitemArrayに入れる
            i = i + 1
        }
    }
    
    
    
    // MARK - セルの数を指定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    
    
    // MARK - セルのカスタマイズ
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたセルに実行される処理
        
        let item = itemArray[indexPath.row]
        
        // チェックマーク
        item.done = !item.done
        
        // リロードしてUIに反映
        self.tableView.reloadData()
        
        // セルを選択した時の背景の変化を遅くする
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        // プラスボタンが押された時に実行される処理
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "リストを作成", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "追加", style: .default) { (action) in
            // 「リストに追加」を押された時に実行される処理
            
            let newItem: Item = Item(title: textField.text!) //
            // アイテム追加処理
            self.itemArray.append(newItem)
            self.saveArray.append(textField.text!)
            self.userDefaults.set(self.saveArray, forKey: "saveData")
            print(self.userDefaults.array(forKey: "saveData") as! [String])
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "なにがしたいですか？"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // アイテム削除処理
        itemArray.remove(at: indexPath.row)
        saveArray.remove(at: indexPath.row)
        userDefaults.set(self.saveArray, forKey: "saveData")
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    @IBAction func saveMemo() {
        
//        saveDate.set()
        
        //  保存
        userDefaults.set("保存する内容", forKey: "key01")
        userDefaults.set(100, forKey: "key02")

    }
    
    

    
}
