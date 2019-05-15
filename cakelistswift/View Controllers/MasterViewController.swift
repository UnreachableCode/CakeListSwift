//
//  MasterViewController.swift
//  cakelistswift
//
//  Created by Charlie Finlayson on 15/05/2019.
//  Copyright © 2019 Charlie Finlayson. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [[String:String]]()
    
    var refreshCtrl: UIRefreshControl!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        self.cache = NSCache()
        
        DispatchQueue.main.async { 
            self.getData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CakeCell
        
        let dictionary = objects[indexPath.row]
        cell.titleLabel.text = dictionary["title"]
        cell.descriptionLabel.text = dictionary["desc"]
        
        let imageUrl = dictionary["image"] as! String
        let url:URL! = URL(string: imageUrl)
        
        task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
            if let data = try? Data(contentsOf: url){
                let img:UIImage! = UIImage(data: data)
                
                DispatchQueue.main.async {
                    cell.cakeImageView.image = img
                }
            }
        })
            
        task.resume()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    fileprivate func getData(){
        guard let url = URL(string: "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let responseData = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                guard let dataList = responseData as? [[String:String]] else {
                    return
                }
                
                self.objects = dataList;
                self.tableView.reloadData()
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
