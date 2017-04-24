//
//  ViewController.swift
//  Created by Alexia Munoz (RIT Student) on 2/8/17.
//  Copyright © 2017 Alexia Munoz (RIT Student). All rights reserved.
//

import UIKit

var SelectedList:[String] = []

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var WordList = wordBank()
    
    static var VC = ViewController()
    
    var words:[String] = wordBank.share.fetchList(category: "musical")
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //Done Button
    @IBAction func unwindToMain(segue:UIStoryboardSegue){
        if segue.identifier == "DoneTap"{
            
            for view in view.subviews{
                if(view is UILabel){
                view.removeFromSuperview()
                }
            }
              words = SelectedList
            placeWords()
        }
    }
    
    @IBOutlet var bg: UIImageView!
    
    //share Button
    @IBAction func share(_ sender:AnyObject) {
        let imageToShare = self.view.takeSnapshot()
        let textToShare = "Have a Limerick"
        let objectsToShare:[AnyObject] = [textToShare as AnyObject, imageToShare!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        
        //for iPad
        let popoverMenuViewController = activityVC.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .any
        popoverMenuViewController?.barButtonItem = sender as? UIBarButtonItem
        
    
        
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    //Changing Background
    var backgroundImage: UIImage?
    
    @IBAction func cameraButtonTapped(_ sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: { imageP in })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        picker.dismiss(animated: true, completion: nil)
        backgroundImage = image
        bg.image = backgroundImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        words = AppData.shared.wordList
        
        print(AppData.shared.wordList)
        placeWords()
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveDefaultsData), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        
        
    }
    
    func placeWords(){
        
        let leftRight = UIInterpolatingMotionEffect(keyPath: "center.x",type:.tiltAlongHorizontalAxis)
        
        leftRight.minimumRelativeValue = -20.0
        leftRight.maximumRelativeValue = 20.0
        
        let topBottom = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        
        topBottom.minimumRelativeValue = -20.0
        topBottom.maximumRelativeValue = 20.0
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [leftRight,topBottom]
        
        view.backgroundColor = UIColor.lightGray
        var previousWord: CGFloat = 0.0
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        for word in words{
            let l = UILabel()
            l.backgroundColor = UIColor.white
            l.text = " \(word)  "
            l.textAlignment = .center
            
            //Adjusting Font Size based on device
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
            l.font = l.font.withSize(40)
            default:
              l.font = l.font.withSize(20)
            }
            
            l.sizeToFit()
            if(words[0] == word){
                x = 5 + (l.frame.size.width/2)
                y = (30 + l.frame.size.height)
            }
            else{
                if((x + (l.frame.size.width + previousWord) + 5) > view.frame.width){
                    x = 5 + (l.frame.size.width/2)
                    y = y + l.frame.size.height + 10
                }
                else{
                    x = x + previousWord + (l.frame.size.width/2) + 5
                }
            }
            
            l.center = CGPoint(x:x, y:y)
            view.addSubview(l)
            previousWord = l.frame.width/2
            l.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            l.addGestureRecognizer(panGesture)
            l.addMotionEffect(group)
        }
    }
    
    func doPanGesture(panGesture:UIPanGestureRecognizer){
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWordSegue"{
            let wordVC = segue.destination.childViewControllers[0] as! WordTableVC
            wordVC.title = "Choose a Genre"
        }
    }
    
    func saveDefaultsData() {
        AppData.shared.wordList = SelectedList
        AppData.shared.saveDefaultsData()
    }

}

