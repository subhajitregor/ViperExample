//
//  CommentController.swift
//  ExampleApp
//
//  Created by subhajit on 25/06/22.
//

import UIKit

protocol CommentDisplayLogic: AnyObject {
    func displayOnSuccess(comments: [CommentViewModel])
}

final class CommentController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tbv = UITableView(frame: .zero)
        tbv.translatesAutoresizingMaskIntoConstraints = false
        
        tbv.estimatedRowHeight = 60
        
        tbv.dataSource = self
        
        return tbv
    }()
    
    private var commentBoxContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()
    
    private lazy var commentBox: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Add new comment..."
        return tf
    }()
    
    private lazy var addCommentButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(userTappedCommentCTA(_:)), for: .touchUpInside)
        
        return button
        
    }()
    
    private var presenter: CommentBusinessLogic?
    
    private var viewModels: [CommentViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    func setPresenter(_ presenter: CommentBusinessLogic) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        setUpViews()
        presenter?.fetchComments()
    }
    
    @IBAction func userTappedCommentCTA(_ sender: UIButton) {
        presenter?.createNewComment(comment: commentBox.text ?? "")
    }
}

private extension CommentController {
    func setUpViews() {
        
        commentBoxContainer.addSubviews([commentBox,
                                        addCommentButton])
        
        commentBox.anchor(top: commentBoxContainer.topAnchor,
                          leading: commentBoxContainer.leadingAnchor,
                          bottom: commentBoxContainer.bottomAnchor,
                          trailing: addCommentButton.leadingAnchor,
                          padding: .init(top: 16,
                                         left: 16,
                                         bottom: 16,
                                         right: 16))
        
        addCommentButton.anchor(top: commentBoxContainer.topAnchor,
                                leading: nil,
                                bottom: commentBoxContainer.bottomAnchor,
                                trailing: commentBoxContainer.trailingAnchor,
                                padding: .init(top: 16,
                                               left: 0,
                                               bottom: 16,
                                               right: 16),
                                size: .init(width: 60, height: 40))
        
        view.addSubviews([tableView,
                          commentBoxContainer])
        
        commentBoxContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                   leading: view.safeAreaLayoutGuide.leadingAnchor,
                                   bottom: nil,
                                   trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        tableView.anchor(top: commentBoxContainer.bottomAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
    }
}

extension CommentController: CommentDisplayLogic {
    func displayOnSuccess(comments: [CommentViewModel]) {
        commentBox.text = nil
        viewModels = comments
    }
}

extension CommentController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CommentCell")
        
        cell.textLabel?.text = viewModels[indexPath.row].comment
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = viewModels[indexPath.row].postedTime.toString(from: .hhmmssFormat)
        
        return cell
    }
}
