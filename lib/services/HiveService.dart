import 'package:flutter_app8/models/ModelProducts.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveService {
  Future<bool> isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return openBox.values.length != 0;
  }

  addBoxes(List<Datum> items, String boxName) async {
    print("adding boxes");
    final Box<Datum> openBox = await Hive.openBox(boxName);
    // if(openBox.length != 0 ) {
    // openBox.clear();
    // }
    for (Datum item in items) {
      List<Datum> datums = openBox.values
          .where((element) => element.id == item.id)
          .toList();
      if (datums != null && datums.length == 0) {
        openBox.add(item);
      }
    }
  }
    updateBox<T>(List<T> items, String boxName) async {
      print("updating boxes");
      final openBox = await Hive.openBox(boxName);
      openBox.clear();
      for (var item in items) {
        openBox.add(item);
      }
    }

    Future<List<Datum?>> getBoxes<Datum>(String boxName) async {
      List<Datum?> boxList = [];

      final Box<Datum> openBox = await Hive.openBox(boxName);

      int length = openBox.length;

      for (int i = 0; i < length; i++) {
        boxList.add(openBox.getAt(i));
      }

      return boxList;
    }
  }
