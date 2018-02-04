//
//  QuestionsContainerViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/2/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionsContainerViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var containerViewQuestion: UIView!
    @IBOutlet var btnNextOrSubmit: UIButton!
    @IBOutlet var btnPrevious: UIButton!
    
    var subsubCategory : SubSubCategory?
    var currentQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if subsubCategory != nil {
            
            presentQuestions(currentQuestion: currentQuestion)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentQuestions(currentQuestion : Int){
        
        if subsubCategory!.questions != nil && subsubCategory!.questions!.count > currentQuestion{
            
            switch subsubCategory?.questions[currentQuestion].type {
                
            case QuestionTypes.Antonym.rawValue?:
                
                
                
                break
                
            case QuestionTypes.Complete.rawValue?:
                
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initCompleteQuestionsView()
                
                break
                
            case QuestionTypes.Dictation.rawValue?:
                
                break
                
            default:
                break
                
            }
        }
        
    }
    
    func initCompleteQuestionsView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionCompleteVC") as? QuestionCompleteViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestion].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
        }
    }
    

}
