//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by siyeon park on 2023/12/05.
//

import UIKit

class Section {
    let title: String
    let options: [String]
    var isOpened = false

    init(title: String, options: [String], isOpened: Bool = false) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}

final class ViewController: UIViewController {

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var sections = [Section]()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()

        sections = [
            Section(title: "Section1", options: [1, 2, 3].compactMap({ return "Cell \($0)"})),
            Section(title: "Section2", options: [1, 2, 3].compactMap({ return "Cell \($0)"})),
            Section(title: "Section3", options: [1, 2, 3].compactMap({ return "Cell \($0)"})),
            Section(title: "Section4", options: [1, 2, 3].compactMap({ return "Cell \($0)"}))
        ]
    }
}

extension ViewController {
    func setupUI() {
        view.addSubview(tableView)
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        print("section \(section)")
        if section.isOpened {
            // section title 때문에 1을 위에서 추가
            return section.options.count + 1
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if indexPath.row == 0 {
            cell.textLabel?.text = sections[indexPath.section].title
            cell.backgroundColor = .systemBlue
        } else {
            // section title 때문에 1을 위에서 추가한 부분을 빼주는 것
            cell.textLabel?.text = sections[indexPath.section].options[indexPath.row - 1]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // section title을 탭한 경우에만 확장이 가능하게 처리
        if indexPath.row == 0 {
            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("tapped sub cell")
        }
    }
}

