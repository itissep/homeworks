import Foundation

enum NetworkingService {
    
    enum Request {
        case character(Int)
        case characters(Int, CharacterStatus)
        case episode(String)
        case location(String)
        
        private static let baseURL = "https://rickandmortyapi.com/api/"
        
        var urlString: String {
            switch self {
            case .character(let id):
                return "\(Self.baseURL)character/\(id)"
            case .characters(let page, let status):
                var statusQuery =  ""
                if status != .all {
                    statusQuery = "&status=" + status.rawValue
                }
                return "\(Self.baseURL)character/?page=\(page)" + statusQuery
            case .episode(let url):
                return url
            case .location(let url):
                return url
            }
        }
    }
    
    static func fetch(_ request: Request) async throws -> Data {
        let url = URL(string: request.urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}

extension Data {
    func toCharacter() throws -> Character {
        try JSONDecoder().decode(Character.self, from: self)
    }
    
    func toAPIResponse() throws -> APIResponse {
        try JSONDecoder().decode(APIResponse.self, from: self)
    }
    
    func toEpisode() throws -> Episode {
        try JSONDecoder().decode(Episode.self, from: self)
    }
}
