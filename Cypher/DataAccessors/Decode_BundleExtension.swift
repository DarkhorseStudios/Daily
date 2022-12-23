import Foundation


extension Bundle {
func decode<Type: Decodable>(fromFileName: String) -> Type {
guard let url = try? Bundle.main.url(forResource: fromFileName, withExtension: nil) else {
fatalError("URL not found for type  from file: \(fromFileName)")
}//guard

guard let data = try? Data(contentsOf: url) else {
fatalError("url could not be converted to data.")
}//guard

let decoder = JSONDecoder()
guard let loadedType = try? decoder.decode(Type.self, from: data) else {
print("Bundle extension failed to load the generic Type from \(fromFileName)")
fatalError("Type could not be loaded.")
}//guard

return loadedType
}//func
}//extension
