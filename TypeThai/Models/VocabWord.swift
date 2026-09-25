import Foundation

// Identifiable means that Swift can tell instances apart
// Codable means this type can be converted to/from a storable or transferable format (like JSON)
struct VocabWord: Identifiable, Codable {
    let id = UUID()
    let thai: String
    let pronunciation: String
    let english: String
    let type: String
}
