//
//  DronMissionHistoryViewModel.swift
//  Dron
//
//  Created by Alexander on 28.08.2018.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronMissionHistoryViewModel: NSObject {
    
    var missionInfoModel: [DronMissionInfoDTO]?
    var tableView: UITableView?
    var loadingData = false
    var page = DronAppConstants.URLConstants.pageForAccountMission
    
    init(missionInfoModel: [DronMissionInfoDTO]) {
        super.init()
        self.missionInfoModel = missionInfoModel
        NotificationCenter.default.addObserver(self, selector:#selector(updateTableView), name: NSNotification.Name(rawValue: "DronMissionHistoryViewModel"), object: nil)
    }
    
    @objc func updateTableView() {
        self.tableView?.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension DronMissionHistoryViewModel : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.missionInfoModel!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DronMissionHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: DronMissionHistoryTableViewCell.self), for: indexPath) as! DronMissionHistoryTableViewCell
        let missionInfo = missionInfoModel![indexPath.row]
        cell.missionIdLabel.text = "\(missionInfo.id)"
        if let droneId = missionInfo.droneId {
            cell.droneIdLabel.text = "\(droneId)"
        } else {
            cell.droneIdLabel.text = "nil"
        }
        let date = Date(timeIntervalSince1970: Double(missionInfo.date)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.ReferenceType.default
        let localDate = dateFormatter.string(from: date)
        cell.createdAtLabel.text = localDate
        cell.statusLabel.text = missionInfo.status
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !loadingData && indexPath.row == self.missionInfoModel!.count - 1 {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            loadingData = true
            page += 1
            InjectorContainer.shared.dronServerProvider.getAccountMissions(page: self.page, size: DronAppConstants.URLConstants.sizeForAccountMission) { (response, error) -> (Void) in
                let result = response as! [DronMissionInfoDTO]
                if error == nil && result.count != 0 {
                    DispatchQueue.main.async {
                        self.missionInfoModel = InjectorContainer.shared.dronServerProvider.getAccountMissionsDTO()
                        tableView.reloadData()
                        self.loadingData = false
                    }
                }
                tableView.tableFooterView = nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        InjectorContainer.shared.dronServerProvider.setMissionInfoDTO(dronMissionInfoDTO: self.missionInfoModel![indexPath.row])
        InjectorContainer.shared.dronUIManager.changeTabWithIndex(page: 1)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return DronMissionHistoryTableHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
