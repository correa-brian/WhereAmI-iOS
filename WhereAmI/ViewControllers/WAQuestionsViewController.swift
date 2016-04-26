//
//  WAQuestionsViewController.swift
//  WhereAmI
//
//  Created by Brian Correa on 4/21/16.
//  Copyright © 2016 milkshake-systems. All rights reserved.
//

import UIKit
import Alamofire

class WAQuestionsViewController: WAViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var questions = Array<WAQuestion>()

    //Data Goes in init functions
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Questions"
        self.tabBarItem.image = UIImage(named: "question.png")
        
//        let notification = NSNotification(name: "ImageDownloaded", object: nil, userInfo: nil)
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
                                       selector: #selector(WAQuestionsViewController.notificationReceived(_:)),
                                       name: "ImageDownloaded",
                                       object: nil)
    }
    
    func notificationReceived(note: NSNotification){
        print("notificationReceived")
        self.collectionView.reloadData()
    }
    
    //Views goes in here
    
    override func loadView() {
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(red: 148/255, green: 158/255, blue: 194/255, alpha: 1)
        
        let collectionViewLayout = WACollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor.clearColor()
        
        self.collectionView.registerClass(WACollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        
        view.addSubview(self.collectionView)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(WAQuestionsViewController.createQuestion(_:)))
        
        let url = "http://localhost:3000/api/question"
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            if let JSON = response.result.value as? Dictionary<String, AnyObject>{
//                print("\(JSON)")
                
                if let results = JSON["results"] as? Array<Dictionary<String, AnyObject>>{
//                    self.questions = results
                    
                    for i in 0..<results.count {
                        let info = results[i]
                        let question = WAQuestion()
                        question.populate(info)
                        self.questions.append(question)
                        
                    }
//                    print("Questions------\(self.questions)")
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.collectionView.reloadData()
                    })
                }
            }
        }
    }
    
    func createQuestion(btn: UIBarButtonItem){
        print("createQuestion")
        
        presentViewController(WACreateQuestionViewController(), animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.questions.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let question = self.questions[indexPath.row]
        
        let cellId = "cellId"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! WACollectionViewCell
        
        if(question.imageData != nil){
            cell.imageView.image = question.imageData
            return cell
        }
        
        cell.imageView.image = nil
        question.fetchImage()
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
