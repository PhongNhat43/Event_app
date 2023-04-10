//
//  ViewController.swift
//  MVVM_App
//
//  Created by devsenior on 10/04/2023.
//

import UIKit

class AnimalViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let vm = EventViewModel.sharedInstance
    
    var data:[Event] = []
    
//    var animalViewModel: AnimalViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initTableView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.data.removeAll()
        vm.loadTasks {
            tableView.reloadData()
        }
    }
    
    private func initTableView() {
         tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
         tableView.delegate = self
         tableView.dataSource = self
     
    }
    
    @IBAction func addButton(_ sender: Any) {
        let vc = AddViewController(nibName: "AddViewController", bundle: nil) as! AddViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AnimalViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return vm.events.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
            let data = vm.events[indexPath.row]
            cell.titleLabel.text = data.title
            cell.descLabel.text = data.desc
            cell.imageEvent?.image = UIImage(data: (data.image as? Data)!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let timeString = dateFormatter.string(from: data.date)
            cell.timeLabel?.text = timeString
            
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditViewController(nibName: "EditViewController", bundle: nil) as! EditViewController
        vc.event = vm.events[indexPath.row]
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}

