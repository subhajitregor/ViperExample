//
//  CommentInteractor.swift
//  ExampleApp
//
//  Created by subhajit on 25/06/22.
//

import Foundation

struct Comment {
    let comment: String
    let time: Date
}

protocol CommentInteractorLogic {
    func fetchComments()
    func addNewComment(comment: Comment)
}

final class CommentInteractor {
    private var models: [Comment] = []
    private var output: CommentInteractorOutput!
    
    func set(output: CommentInteractorOutput) {
        self.output = output
    }
}

extension CommentInteractor: CommentInteractorLogic {
    func fetchComments() {
        // Api -
        output.fetchCommentsSuccess(comments: models)
    }
    
    func addNewComment(comment: Comment) {
        models.append(comment)
        output.fetchCommentsSuccess(comments: models)
    }
}
