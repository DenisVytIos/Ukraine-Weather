//
//  DetailViewController.swift
//  Ukraine Weather
//
//  Created by Denis on 9/9/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  

//  let parameter: String = ""
    var city: String?
  var tempMain: String?
  @IBOutlet weak var mainTempLabel: UILabel!
  
  @IBOutlet weak var label: UILabel!
//    init(parameter: String) {
//    self.parameter = parameter
//      super.init(nibName: nil, bundle:)
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }

  
 
  override func viewDidLoad() {
        super.viewDidLoad()
    self.mainTempLabel.textColor = UIColor.black
    self.mainTempLabel.text = tempMain
    print(self.tempMain)
    setupNavigationBar()
//     self.view.backgroundColor = UIColor.green
//    self.label.text = self.city
//    temp.text = self.parameter
//  
//     temp.backgroundColor = UIColor.black
//    temp.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }
  
  fileprivate func setupNavigationBar() {
    
   
    self.navigationItem.title = self.city
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
}

//extension DetailViewController: UICollectionViewController {
//  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 2
//  }
//  
//  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
//    cell.dateLabel.text = String("Tue 3")
//    return cell
//  }
//  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//   let size = CGSize(width: 100, height: 100)
//    return size
//  }
//}
