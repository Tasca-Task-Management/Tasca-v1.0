//
//  DashboardTableViewCell.swift
//  mc2apps
//
//  Created by Agnes Felicia on 24/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var milestoneLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var dashboardTaskView: UIView!
    //    @IBOutlet weak var noTaskView: UIView!
    @IBOutlet weak var noTaskLabel: UILabel!
    @IBOutlet weak var taskTableViewCell: UITableView!
    
    var task:[Task] = []{
        didSet{
            taskTableViewCell.reloadData()
        }
    }
    var color:String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskTableViewCell.reloadData()
        
        
        taskTableViewCell.dataSource = self
        taskTableViewCell.register(UINib(nibName: "DashboardTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        
        switch color {
        case "purple":
            taskTableViewCell.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
        case "green":
            taskTableViewCell.layer.backgroundColor = UIColor(red: 0.596, green: 0.816, blue: 0.369, alpha: 1).cgColor
        case "blue":
            taskTableViewCell.layer.backgroundColor = UIColor(red: 0.486, green: 0.784, blue: 1, alpha: 1).cgColor
        case "orange":
            taskTableViewCell.layer.backgroundColor = UIColor(red: 0.992, green: 0.753, blue: 0.333, alpha: 1).cgColor
        default:
            taskTableViewCell.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func colorTable(color: String, cell: UITableView){
        switch color {
        case "purple":
            cell.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
        case "green":
            cell.layer.backgroundColor = UIColor(red: 0.596, green: 0.816, blue: 0.369, alpha: 1).cgColor
        case "blue":
            cell.layer.backgroundColor = UIColor(red: 0.486, green: 0.784, blue: 1, alpha: 1).cgColor
        case "orange":
            cell.layer.backgroundColor = UIColor(red: 0.992, green: 0.753, blue: 0.333, alpha: 1).cgColor
        default:
            cell.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
        }
    }
    
    func colorCell(color: String, cell: UITableViewCell){
        switch color {
        case "purple":
            cell.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
        case "green":
            cell.layer.backgroundColor = UIColor(red: 0.596, green: 0.816, blue: 0.369, alpha: 1).cgColor
        case "blue":
            cell.layer.backgroundColor = UIColor(red: 0.486, green: 0.784, blue: 1, alpha: 1).cgColor
        case "orange":
            cell.layer.backgroundColor = UIColor(red: 0.992, green: 0.753, blue: 0.333, alpha: 1).cgColor
        default:
            cell.layer.backgroundColor = UIColor(red: 0.722, green: 0.69, blue: 0.996, alpha: 1).cgColor
        }
    }
    
    
}


extension DashboardTableViewCell: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! DashboardTaskTableViewCell
        let text = "- "+task[indexPath.row].taskName!
        cell.selectionStyle = .none
        colorCell(color: color ?? "purple", cell: cell)
        
        if task[indexPath.row].isChecklist == true {
            cell.taskLabel.attributedText = text.strikeThrough()
        } else {
            cell.taskLabel.attributedText = text.unstrikeThrough()
        }
        
        return cell
    }
}
