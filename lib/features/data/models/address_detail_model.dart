class AddressDetailModel {
//   Responset? responset;
//
//   AddressDetailModel({
//     required this.responset,
//   });
//
//   factory AddressDetailModel.fromJson(Map<String, dynamic> json) =>
//       AddressDetailModel(responset: Responset.fromJson(json["response"]));
// }
//
// class Responset {
//   GeoObjectCollection geoObjectCollection;
//
//   Responset({
//     required this.geoObjectCollection,
//   });
//
//   factory Responset.fromJson(Map<String, dynamic> json) =>
//       Responset(
//         geoObjectCollection: json["GeoObjectCollection"] == null
//             ? null
//             : GeoObjectCollection.fromJson(json["GeoObjectCollection"]),
//       );
// }
//
// class GeoObjectCollection {
//   late GeoObjectCollectionMetaDataProperty metaDataProperty;
//   List<FeatureMember>? featureMember;
//
//   GeoObjectCollection(
//       {required this.metaDataProperty, required this.featureMember});
//
//   factory GeoObjectCollection.fromJson(Map<String, dynamic>json)=>
//       GeoObjectCollection(metaDataProperty: json["metaDataProperty"],
//           featureMember: List<FeatureMember>.from(
//               json["featureMember"].map((x) => FeatureMember.fromJson(x))),
//       );
//
}
//
// class GeoObjectCollectionMetaDataProperty {}
//
// class FeatureMember {}
