import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;
  @EnviedField(varName: 'API_READ_ACCESS_TOKEN', obfuscate: true)
  static final String apiReadAccessToken = _Env.apiReadAccessToken;
}
