class CommentStorage {
    
    private var comments: [CommentM] = []
    
    init() { }
    
    init(comments: [CommentM]) {
        self.comments = comments
    }
    
    func numberOfComment() -> Int {
        return comments.count
    }
    
    func comment(at index: Int) -> CommentM {
        return comments[index]
    }
    
}
