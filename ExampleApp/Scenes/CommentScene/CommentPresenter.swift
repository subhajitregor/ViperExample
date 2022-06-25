//
//  CommentPresenter.swift
//  ExampleApp
//
//  Created by subhajit on 25/06/22.
//

import Foundation

protocol CommentBusinessLogic {
    func fetchComments()
    func createNewComment(comment: String)
}

protocol CommentInteractorOutput {
    func fetchCommentsSuccess(comments: [Comment])
}

final class CommentPresenter {
    private weak var displayView: CommentDisplayLogic?
    private var interactor: CommentInteractorLogic
    
    init(view: CommentDisplayLogic,
         interactor: CommentInteractorLogic) {
        self.displayView = view
        self.interactor = interactor
    }
}

extension CommentPresenter: CommentBusinessLogic {
    func fetchComments() {
        interactor.fetchComments()
    }
    
    func createNewComment(comment: String) {
        let newcomment = comment.trimmingCharacters(in: .whitespaces)
        guard !newcomment.isEmpty else {
            // can display error view: displayView.showError(message: "...")
            return
        }
        interactor.addNewComment(comment: Comment(comment: newcomment, time: Date.now))
    }
}

extension CommentPresenter: CommentInteractorOutput {
    func fetchCommentsSuccess(comments: [Comment]) {
        displayView?.displayOnSuccess(comments: self.createViewModel(comments: comments))
    }
}

private extension CommentPresenter {
    func createViewModel(comments: [Comment]) -> [CommentViewModel] {
        comments.map { CommentViewModel(comment: $0.comment,
                                        postedTime: $0.time)}.reversed()
    }
}
