//
//  addCourseViewController.swift
//  Skeleton
//
//  Created by Dan Finn on 4/22/17.
//  Copyright © 2017 JohnGarza. All rights reserved.
//

import UIKit

class addCourseViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    let dbAccessor = DBManager(poolID: "us-east-1:63f21831-90a5-433e-bcee-4ece294731bd")
    
    @IBOutlet weak var addCourseView: UIView!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var addCourseBtn: UIButton!
    @IBOutlet weak var titleField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionField.delegate = self
        descriptionField.layer.borderWidth = 3
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        descriptionField.layer.cornerRadius = 5
        descriptionField.text = "Enter a description"
        codeField.placeholder = "E81 CSE 104"
        titleField.placeholder = "Web Development"
        
        codeField.delegate = self
        titleField.delegate = self
        
        codeField.layer.borderWidth = 1
        titleField.layer.borderWidth = 1
        codeField.layer.cornerRadius = 3
        titleField.layer.cornerRadius = 3
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        addCourseView.backgroundColor = UIColor(hue: 0.5778, saturation: 0.93, brightness: 0.9, alpha: 1.0)
        
        addCourseBtn.setTitleColor(UIColor.white, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    @IBAction func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addReview(){
        print("here")
        guard let code = codeField.text else {return}
        guard let title = titleField.text else {return}
        guard let description = descriptionField.text else {return}
        
        if (code == "" || title == "" || description == ""){
            let alertController = UIAlertController(title: "ERROR", message: "Please fill out all fields", preferredStyle: .alert)
            let confAction = UIAlertAction(title: "OKAY", style: .default, handler: nil)
            
            alertController.addAction(confAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        

        if dbAccessor.getCourse(courseCode: code) != nil{
            let alertController = UIAlertController(title: "ERROR", message: "Course already exists!", preferredStyle: .alert)
            let confAction = UIAlertAction(title: "OKAY", style: .default, handler: nil)
            
            alertController.addAction(confAction)
            present(alertController, animated: true, completion: nil)
            return
            
        }
        
        
        let newCourse = Course()
        
        newCourse?.Code = code
        newCourse?.Title = title
        newCourse?.Description = description
        
        print("Added Course")
        
        _ = dbAccessor.addCourse(course: newCourse!)
        
        
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor(hue: 0.55, saturation: 1, brightness: 0.97, alpha: 1.0).cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(hue: 0.55, saturation: 1, brightness: 0.97, alpha: 1.0).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
