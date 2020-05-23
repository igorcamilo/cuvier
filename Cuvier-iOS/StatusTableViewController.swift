//
//  StatusTableViewController.swift
//  Cuvier-iOS
//
//  Created by Igor Camilo on 23.05.20.
//  Copyright © 2020 Igor Camilo. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct Status: Codable {
    var content: String
}

class StatusTableViewController: UITableViewController {
    var publicTimeline: [Status] = [] {
        didSet { tableView.reloadData() }
    }

    var observer: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: "StatusTableViewCell")
        let publicTimelineURL = URL(string: "https://mastodon.social/api/v1/timelines/public")!
        observer = URLSession.shared.dataTaskPublisher(for: publicTimelineURL)
            .map(\.data)
            .decode(type: [Status].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.publicTimeline = $0 })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        publicTimeline.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "StatusTableViewCell", for: indexPath)
        if let statusTableViewCell = tableViewCell as? StatusTableViewCell {
            let status = publicTimeline[indexPath.row]
            statusTableViewCell.contentLabel.text = status.content
        }
        return tableViewCell
    }
}
