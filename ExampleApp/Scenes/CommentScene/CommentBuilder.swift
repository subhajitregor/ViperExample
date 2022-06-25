//
//  CommentBuilder.swift
//  ExampleApp
//
//  Created by subhajit on 25/06/22.
//

import Foundation

final class CommentBuilder {
    // Can set dependencies
    
    func build() -> CommentController {
        // TODO: Change with proper implemntation
        let viewcontroller = CommentController()
        
        let interactor = CommentInteractor()
        let presenter = CommentPresenter(view: viewcontroller, interactor: interactor)
        
        interactor.set(output: presenter)
        viewcontroller.setPresenter(presenter)
        
        return viewcontroller
    }
}
