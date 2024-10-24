import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get devFileName =>
      ".env.dev"; //kReleaseMode ? ".env.prod" : ".env.dev";
  static String get prodFileName => ".env.prod";
  static String get apiUrl => dotenv.env['API_URL'] ?? 'MY_FALLBACK';
  static String get purchaseKey => dotenv.env['public_key'] ?? 'MY_FALLBACK';


}
