
import UIKit
class GetTogetherListViewController: UIViewController {
    let tableView = UITableView()
    var promisses = [Promise]()
    let className = "GetTogetherListViewController"
    let api = Api(apiProtocol: .http, apiUrl: .getPromise, port: 80)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addObservers()
    }
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "약속 리스트"
        [tableView].forEach {
            view.addSubview($0)
        }
        setupConstraint()
        setData()
//        dump(promisses)
        tableView.dataSource = self
        tableView.register(GetTogetherCell.self, forCellReuseIdentifier: "PromiseCell")
        tableView.delegate = self
    }
    private func setupConstraint() {
        let guide = self.view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor,constant: 0),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)
        ])
    }
    func setData() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        api.request(method: .get, notificationName: className, data: ["id": id])
        
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(getData(_:)), name: NSNotification.Name(className), object: nil)
        
    }
    
    @objc func getData(_ notification: Notification) {
        
        guard let data = notification.userInfo?[className] as? [String: Any] else { return }
        guard let json = data["result"] as? [[String: String]] else { return }
        var tempUserList: [Promise] = []
        for promise in json {
            
            guard
                let members = promise["members"],
                let placeTitle = promise["placetitle"],
                let comment = promise["comment"],
                let dateString = promise["date"],
                let addressName = promise["addressName"],
                let latitued = promise["latitude"],
                let longitude = promise["longitude"]
                else { return }
            
                
                
            
            
            
//            let promise = Promise(date: <#T##Date#>, members: members, placeTitle: placeTitle, placeLatitude: , placeLongitude: <#T##Double#>, comment: comment)
            
        }
        
        
        
    }
    
    
    
    
    
}
// MARK: - UITableViewDataSource
extension GetTogetherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promisses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromiseCell", for: indexPath) as! GetTogetherCell
        let data = promisses[indexPath.row]
        cell.commentLabelInfo(comment: data.comment)
        cell.timeLabelInfo(time: "time \(indexPath.row)")
        cell.placeTitleLabelInfo(placeTitle: data.placeTitle)
        cell.membersLabelInfo(members: data.members)
        cell.monthLabelInfo(month: "\(indexPath.row)월")
        cell.dayLabelInfo(day: "\(indexPath.row)")
        cell.weekDayLabelInfo(weekDay: "화")
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GetTogetherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = promisses[indexPath.row]
        let getTogetherDetailVC = GetTogetherDetailViewController()
        getTogetherDetailVC.placeTitleLabel.text = "\(data.placeTitle)"
        getTogetherDetailVC.placeAdressLabel.text = "\(data.placeTitle) 서울특별시 강남구 삼성로 300길 28-1"
        getTogetherDetailVC.dayLabel.text = "\(data.placeLatitude)월 \(data.placeLatitude)일 \(data.placeLatitude)요일"
        getTogetherDetailVC.timeLabel.text = "오후 \(data.placeLatitude)시 \(data.placeLatitude)분"
        getTogetherDetailVC.memberLabel.text = "\(data.members)"
        getTogetherDetailVC.commentLabel.text = "\(data.comment)"
        self.navigationController?.pushViewController(getTogetherDetailVC, animated: true)
    }
}
