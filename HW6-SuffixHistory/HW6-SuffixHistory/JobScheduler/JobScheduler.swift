import Foundation

actor JobScheduler {
    
    private var isRunning = false
    private let jobQueue = JobQueue()
    
    func add(_ job: Job) {
        jobQueue.push(job)
        
        guard !isRunning else {
            return
        }
        
        Task {
            await runNext()
        }
    }
    
    private func prosess(_ word: String) async -> String {
        SuffixSequence(word).map { String($0) }.joined(separator: " | ")
    }
   
    private func runNext() async {
        guard let job = jobQueue.pop() else {
            isRunning = false
            return
        }
        
        isRunning = true
        
        let startDate = Date()
        let suffixes = await prosess(job.word)
        let endDate = Date()

        job.completion(
            ResultItem(
                string: job.word,
                suffixes: suffixes,
                duration: endDate.timeIntervalSince(startDate)
            )
        )
        
        await runNext()
    }
}
