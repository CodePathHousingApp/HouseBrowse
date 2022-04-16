//
//  FeedViewController.swift
//  HouseBrowse
//
//  Created by Cristian Guerrero on 4/15/22.
//

import UIKit
import Parse
import Foundation

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var houses = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let headers = [
            "X-RapidAPI-Host": "us-real-estate.p.rapidapi.com",
            "X-RapidAPI-Key": "70ee5bc02cmsh918bd04c9a9d8b1p1c5f94jsnbd17f2851ba5"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://us-real-estate.p.rapidapi.com/v2/property-detail?property_id=3199790641")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
                delegate.window?.rootViewController = loginViewController
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell") as! HouseCell
//
//        let house = houses[indexPath.row]
//        let title = house["title"] as! String
//        let synopsis = house["overview"] as! String
//
//
//        cell.titleLabel.text = title
//        cell.synopsisLabel.text = synopsis
//
//        let baseUrl = "http://image.tmdb.org/t/p/w185"
//        let posterPath = movie["poster_path"] as! String
//        let posterUrl = URL(string:baseUrl + posterPath)
//
//        cell.posterView.af.setImage(withURL: posterUrl!)
//
//        return cell
//    }
//
//    override func prepare(for segue:
//        UIStoryboardSegue, sender: Any?){
//
//        print("Loading up the details screen")
//        //Find the selected movie
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)!
//        let movie = movies[indexPath.row]
//        //pass the selected movie to the details view controller
//
//        let detailViewController = segue.destination as! MovieDetailsViewController
//        detailViewController.movie = movie
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
