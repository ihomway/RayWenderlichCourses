//
//  ListViewController.swift
//  ClassicPhotos
//
//  Created by Richard Turton on 03/07/2014.
//  Copyright (c) 2014 raywenderlich. All rights reserved.
//

import UIKit
import CoreImage

let dataSourceURL = URL(string:"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist")

class ListViewController: UITableViewController {
	
	var photos = [PhotoRecord]()
	let pendingOperations = PendingOperations()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Classic Photos"
		
		fetcPhotoDetails()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func fetcPhotoDetails() {
		let request = URLRequest(url: dataSourceURL!)
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		
		NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
			
			if let data = data {
				if let datasourceDicationary = try? PropertyListSerialization.propertyList(from: data, format: nil) as! Dictionary<String, AnyObject> {
					for (key, value) in datasourceDicationary {
						guard let url = URL(string: value as? String ?? "") else {
							continue
						}
						
						let photoRecord = PhotoRecord(name: key, url: url)
						self.photos.append(photoRecord)
					}
					
					self.tableView.reloadData()
				}
			} else if let error = error {
				let alert = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
				
				self.present(alert, animated: true, completion: nil)
			}
			
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
	}
	
	// #pragma mark - Table view data source
	
	override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
		return photos.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
		
		if cell.accessoryView == nil {
			let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
			cell.accessoryView = indicator
		}
		
		let indicator = cell.accessoryView! as! UIActivityIndicatorView
		let photDetails = photos[indexPath.row]
		
		cell.textLabel?.text = photDetails.name
		cell.imageView?.image = photDetails.image
		
		switch photDetails.state {
		case .Filtered:
			indicator.stopAnimating()
		case .Failed:
			indicator.stopAnimating()
			cell.textLabel?.text = "Failed to load"
		case .New, .Downloaded:
			indicator.startAnimating()
			if !tableView.isDragging && !tableView.isDecelerating {
				startOperationsForPhotoRecord(photoDetails: photDetails, indexPath: indexPath)
			}
		}
		
		return cell
	}
	
	override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		suspendAllOperations()
	}
	
	override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if !decelerate {
			loadImagesForOnScreenCells()
			resumeAllOperations()
		}
	}
	
	override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		loadImagesForOnScreenCells()
		resumeAllOperations()
	}
	
	func startOperationsForPhotoRecord(photoDetails: PhotoRecord, indexPath: IndexPath) {
		switch photoDetails.state {
		case .New:
			startDownloadForRecord(photoDetails: photoDetails, indexPath: indexPath)
		case .Downloaded:
			startFiltrationForRecord(photoDetails: photoDetails, indexPath: indexPath)
		default:
			print("Do Nothing")
		}
	}
	
	func startDownloadForRecord(photoDetails: PhotoRecord, indexPath: IndexPath)
	{
		if let _ = pendingOperations.downloadInProgress[indexPath] {
			return
		}
		
		let downloader = ImageDownloader(photoRecord: photoDetails)
		downloader.completionBlock = {
			if downloader.isCancelled { return }
			DispatchQueue.main.async {
				self.pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
				self.tableView.reloadRows(at: [indexPath], with: .fade)
			}
		}
		
		pendingOperations.downloadInProgress[indexPath] = downloader
		pendingOperations.downloadQueue.addOperation(downloader)
	}
	
	func startFiltrationForRecord(photoDetails: PhotoRecord, indexPath: IndexPath) {
		if let _ = pendingOperations.filtrationsInProgress[indexPath] {
			return
		}
		
		let filterer = ImageFiltration(photoRecord: photoDetails)
		filterer.completionBlock = {
			if filterer.isCancelled { return }
			
			DispatchQueue.main.async {
				self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
				self.tableView.reloadRows(at: [indexPath], with: .fade)
			}
		}
		
		pendingOperations.filtrationsInProgress[indexPath] = filterer
		pendingOperations.filtrationQueue.addOperation(filterer)
	}
	
	func loadImagesForOnScreenCells() {
		if let pathsArray = tableView.indexPathsForVisibleRows {
			var allPendingOperations = Set(pendingOperations.downloadInProgress.keys)
			allPendingOperations.formUnion(pendingOperations.filtrationsInProgress.keys)
			
			var toBeCancelled = allPendingOperations
			let visiblePaths = Set(pathsArray)
			toBeCancelled.subtract(visiblePaths)
			
			var toBeStarted = visiblePaths
			toBeStarted.subtract(allPendingOperations)
			
			for indexPath in toBeCancelled {
				if let pendingDownload = pendingOperations.downloadInProgress[indexPath] {
					pendingDownload.cancel()
				}
				pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
				
				if let pendingFiltration = pendingOperations.filtrationsInProgress[indexPath] {
					pendingFiltration.cancel()
				}
				pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
			}
			
			for indexPath in toBeStarted {
				let recordToProcess = photos[indexPath.row]
				startOperationsForPhotoRecord(photoDetails: recordToProcess, indexPath: indexPath)
			}
		}
	}
	
	func suspendAllOperations() {
		pendingOperations.downloadQueue.isSuspended = true
		pendingOperations.filtrationQueue.isSuspended = true
	}
	
	func resumeAllOperations() {
		pendingOperations.downloadQueue.isSuspended = false
		pendingOperations.filtrationQueue.isSuspended = false
	}
}
