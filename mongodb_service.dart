import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  final String mongoDbUri = 'mongodb://<your-mongo-db-url>';
  final String collectionName = 'hospitals';

  // Fetch nearby hospitals from MongoDB
  Future<List<Map<String, dynamic>>> fetchNearbyHospitals(
      double latitude, double longitude, double radiusInKm) async {
    final db = await Db.create(mongoDbUri);
    await db.open();

    final collection = db.collection(collectionName);

    // Convert radius to radians (6371 is Earth's radius in km)
    double radiusInRadians = radiusInKm / 6371;

    // MongoDB geospatial query
    final hospitals = await collection.find({
      'location': {
        '\$geoWithin': {
          '\$centerSphere': [
            [longitude, latitude],
            radiusInRadians
          ]
        }
      }
    }).toList();

    await db.close();
    return hospitals;
  }
}
