import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fampay/model/card_group.dart';

class CardsRemote {
  Future<List<CardGroup>> fetch({
    required List<String> slugs,
    required String apiBaseUrl,
  }) async {
    final uri = Uri.parse(
      '${apiBaseUrl}?slugs=${Uri.encodeQueryComponent(slugs.join(','))}',
    );
    final res = await http.get(
      uri,
      headers: {
        'accept': 'application/json',
        'user-agent': 'contextual-cards/1.0',
      },
    );

    if (res.statusCode != 200) {
      throw Exception('API error: ${res.statusCode}');
    }

    // Decode the JSON response
    final decodedResponse = json.decode(res.body);
    // Ensure the response is a List and not empty
    if (decodedResponse is List && decodedResponse.isNotEmpty) {
      final Map<String, dynamic> dataMap =
          decodedResponse[0] as Map<String, dynamic>;

      // Extract 'hc_groups' from the response
      final groupsRaw = dataMap['hc_groups'] as List<dynamic>?;
      if (groupsRaw == null || groupsRaw.isEmpty) {
        throw Exception('Unexpected API format: No "hc_groups" found.');
      }

      // Map each group to extract cards and convert them to CardGroup objects
      final cardGroups =
          groupsRaw.map((group) {
            final groupMap = group as Map<String, dynamic>;
            final cards = groupMap['cards'] as List<dynamic>? ?? [];
            return CardGroup.fromJson({
              'id': groupMap['id'],
              'name': groupMap['name'],
              'design_type': groupMap['design_type'],
              'card_type': groupMap['card_type'],
              'cards': cards,
            });
          }).toList();

      return cardGroups;
    } else {
      throw Exception('Unexpected API format: Response is not a valid List.');
    }
  }
}
