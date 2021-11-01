//
//  ImageDownloader.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 01/11/21.
//


import UIKit
class ImageDownloader {
    
    @Published var userIMage: UIImage?
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void ) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) {[weak self] data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            self?.userIMage  = UIImage(data: data)
        }
    }
    
}
