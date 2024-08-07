import 'package:http/http.dart' as http;
import 'dart:convert';

class DbManager {
  // متد برای افزودن تراکنش به MySQL
  Future<void> addData(int amount, DateTime date, String description, String type) async {
    var url = 'https://tricks.se/money_manager/add_transaction.php';
    var response = await http.post(
      Uri.parse(url),
      body: {
        'amount': amount.toString(),
        'date': date.toIso8601String(),
        'description': description,
        'type': type,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add transaction');
    }
  }

  // متد برای دریافت تراکنش‌ها از MySQL
  Future<List<Map<String, dynamic>>> fetchRemoteData() async {
    var url = 'http://tricks.se/money_manager/get_transactions.php';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body);
      return items.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
