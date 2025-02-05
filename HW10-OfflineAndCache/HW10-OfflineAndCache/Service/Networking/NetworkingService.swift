import Foundation

enum Request {
    case character(Int)
    case characters
    case episode(String)
    case location(String)
    
    private static let baseURL = "https://rickandmortyapi.com/api/"
    
    var urlString: String {
        switch self {
        case .character(let id): "\(Self.baseURL)character/\(id)"
        case .characters: "\(Self.baseURL)character/?page=\(1)"
        case .episode(let url): url
        case .location(let url): url
        }
    }
}

protocol NetworkServiceProtocol {
    func fetch(_ request: Request) async throws -> Data
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared: NetworkServiceProtocol = NetworkService()
    
    private init() { }
    
    func fetch(_ request: Request) async throws -> Data {
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
    func toCharacter() throws -> CharacterDTO {
        try JSONDecoder().decode(CharacterDTO.self, from: self)
    }
    
    func toAPIResponse() throws -> APIResponseDTO {
        try JSONDecoder().decode(APIResponseDTO.self, from: self)
    }
    
    func toEpisode() throws -> EpisodeDTO {
        try JSONDecoder().decode(EpisodeDTO.self, from: self)
    }
}
