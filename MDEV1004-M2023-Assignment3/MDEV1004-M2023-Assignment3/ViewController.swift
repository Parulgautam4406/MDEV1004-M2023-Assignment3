//
//  ViewController.swift
//  MDEV1004-M2023-Assignment3
//
//  Created by Parul Gautam on 23/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovies { [weak self] movies, error in
            DispatchQueue.main.async
            {
                if let movies = movies
                {
                    if movies.isEmpty
                    {
                        // Display a message for no data
                        self?.displayErrorMessage("No movies available.")
                    } else {
                        self?.movies = movies
                        self?.tableView.reloadData()
                    }
                } else if let error = error {
                    if let urlError = error as? URLError, urlError.code == .timedOut
                    {
                        // Handle timeout error
                        self?.displayErrorMessage("Request timed out.")
                    } else {
                        // Handle other errors
                        self?.displayErrorMessage(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    func displayErrorMessage(_ message: String)
    {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> Void)
    {
        guard let url = URL(string: "https://mdev1004-m2023-assignment3b.onrender.com/api/list") else
        {
            print("URL Error")
            completion(nil, nil) // Handle URL error
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Network Error")
                completion(nil, error) // Handle network error
                return
            }

            guard let data = data else {
                print("Emprty Response")
                completion(nil, nil) // Handle empty response
                return
            }

            
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                completion(movies, nil) // Success
            } catch {
                completion(nil, error) // Handle JSON decoding error
            }
        }.resume()
    }

}

