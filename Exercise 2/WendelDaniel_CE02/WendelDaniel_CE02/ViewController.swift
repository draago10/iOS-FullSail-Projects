//
//  ViewController.swift
//  WendelDaniel_CE02
//
//  Created by Daniel Wendel on 5/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    var employees = [Employee]()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        accessJson()
        setupUI()
    }
    
    
    let employeeName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let skills : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.sizeToFit()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let pastEmployerTextView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.sizeToFit()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    let pastEmployerCount : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let skillsCount : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextEmployee : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToNextCharacter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let previousEmployee : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToPreviousCharacter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //UI BUTTON FUNCTIONALITY
    @objc func goToNextCharacter(){
        index += 1
        if index < employees.count {
            fillInUI()
        } else{
            index = 0
            fillInUI()
        }
    }
    
    @objc func goToPreviousCharacter(){
        index -= 1
        if index < 0 {
            index = employees.count - 1
            
            fillInUI()
        } else {
            fillInUI()
        }
    }
    
    
    func fillInUI(){
        employeeName.text = "Employee Name: \(employees[index].name)"
        userName.text = "Username: \(employees[index].userName)"
        jobTitle.text = "Job Title: \(employees[index].currentTitle)"
        var skillsString = "Skills:\n"
        
        if employees[index].skills.isEmpty{
            skillsString += "This employee has no listed skills."
        } else{
            for s in employees[index].skills{
                
                skillsString += "\(s)\n"
            }
        }
        
        skills.text = skillsString
        
        var pastEmployerString = "Past Employer(s):\n\n"
        var listNumbers = 1
        
        if employees[index].pastEmployers.isEmpty{
            pastEmployerString += "This employee has no past employers."
        }else{
            for p in employees[index].pastEmployers{
                var responsibility = ""
                for r in p.responsibilities{
                    responsibility += r
                    
                }
                pastEmployerString += "\(listNumbers). \(p.companyName)\nResponsibilities:\n\(responsibility)\n\n"
                listNumbers += 1
            }
        }
       
        pastEmployerTextView.text = pastEmployerString
        
        pastEmployerCount.text = "Past Employers: \(employees[index].numPastEmployers)"
        skillsCount.text = "Skills: \(employees[index].numSkills)"
    }
    
    func setupUI(){
        view.addSubview(employeeName)
        employeeName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        employeeName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        
        view.addSubview(userName)
        userName.topAnchor.constraint(equalTo: employeeName.bottomAnchor, constant: 15).isActive = true
        userName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        
        view.addSubview(jobTitle)
        jobTitle.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 15).isActive = true
        jobTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        
        
        view.addSubview(skills)
        skills.topAnchor.constraint(equalTo: jobTitle.bottomAnchor, constant: 15).isActive = true
        skills.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        skills.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        skills.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        view.addSubview(pastEmployerTextView)
        pastEmployerTextView.topAnchor.constraint(equalTo: skills.bottomAnchor, constant: 15).isActive = true
        pastEmployerTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        pastEmployerTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        pastEmployerTextView.heightAnchor.constraint(equalToConstant: 225).isActive = true
        
        view.addSubview(pastEmployerCount)
        pastEmployerCount.topAnchor.constraint(equalTo: pastEmployerTextView.bottomAnchor, constant: 15).isActive = true
        pastEmployerCount.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        
        
        view.addSubview(skillsCount)
        skillsCount.topAnchor.constraint(equalTo: pastEmployerTextView.bottomAnchor, constant: 15).isActive = true
        skillsCount.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        
        view.addSubview(previousEmployee)
        previousEmployee.topAnchor.constraint(equalTo: pastEmployerCount.bottomAnchor, constant: 25).isActive = true
        previousEmployee.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 55).isActive = true
        previousEmployee.widthAnchor.constraint(equalToConstant: 125).isActive = true
        previousEmployee.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nextEmployee)
        nextEmployee.topAnchor.constraint(equalTo: pastEmployerCount.bottomAnchor, constant: 25).isActive = true
        nextEmployee.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -55).isActive = true
        nextEmployee.widthAnchor.constraint(equalToConstant: 125).isActive = true
        nextEmployee.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        fillInUI()
        
    }
    
    //MARK: JSON METHODS
    
    func accessJson(){
        if let path = Bundle.main.path(forResource: "EmployeeData", ofType: ".json"){
            let url = URL(fileURLWithPath: path)
            do{
                let data = try Data.init(contentsOf: url)
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                parseJson(jsonObject: jsonObj)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func parseJson(jsonObject: [Any]?){
        guard let json = jsonObject else {print("Failed to parse"); return}
        for employees in json {
            //Pull first level info
            guard let objects = employees as? [String : Any],
                  let name = objects["employeename"] as? String,
                  let userName = objects["username"] as? String,
                  let macAddress = objects["macaddress"] as? String,
                  let currentTitle = objects["current_title"] as? String,
                  let skills = objects["skills"] as? [String],
                  //Get past employers information
                  let pastEmployers = objects["past_employers"] as? [[String : Any]]
            else {continue}
            
            //create a empty past employers array
            var pastEmployer = [PastEmployer]()
            for pastE in pastEmployers{
                
                //Check if the employee has past employers
                if let company = pastE["company"] as? String, let responsibilites = pastE["responsibilities"] as? [String] {
                    print(company)
                    let pE = PastEmployer(companyName: company, responsibilities: responsibilites)
                    pastEmployer.append(pE)
                }
            }
            
            //Create the new employee
            let newEmployee = Employee(name: name, userName: userName, macAddress: macAddress, currentTitle: currentTitle, skills: skills, pastEmployers: pastEmployer)
            self.employees.append(newEmployee)
        }
        print("HERE")
    }
}

