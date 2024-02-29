import 'package:get_storage/get_storage.dart';

final GetStorage storage = GetStorage();
const String baseUrl = "http://10.0.2.2:8000/api/";
final String userToken = storage.read('token');

//http://127.0.0.1 //web
//http://10.0.2.2 //avd