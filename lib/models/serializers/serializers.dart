library serializers;


import 'package:built_value/serializer.dart';
import 'package:material_app/models/user/user.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:material_app/models/wrappers/error_handler.dart';

part 'serializers.g.dart';

@SerializersFor([
  User,
  ErrorHandler
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();