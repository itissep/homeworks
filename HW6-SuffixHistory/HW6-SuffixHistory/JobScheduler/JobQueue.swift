import Foundation

final class JobQueue {
    private var queue = [Job]()
    
    func pop() -> Job? {
        queue.isEmpty ? nil : queue.removeFirst()
    }
    
    func push(_ job: Job) {
        queue.append(job)
    }
}
