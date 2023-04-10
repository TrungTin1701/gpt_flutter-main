import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIHandler {
  final _openAI = OpenAI.instance.build(
    token: '<Your API Key>>',
    baseOption: HttpSetup(
      // receiveTimeout: const Duration(seconds: 60),
      // connectTimeout: const Duration(seconds: 60),
      connectTimeout: Duration(minutes: 1), // 60 seconds
      receiveTimeout: Duration(minutes: 1), // 60 seconds
    ),
  );

  Future<String> getResponse(String message) async {
    try {
      final request = await ChatCompleteText(messages: [
        Map.of({"role": "user", "content": message})
      ], maxToken: 200, model: kChatGptTurbo0301Model);

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message.content.trim();
      }

      return 'Some thing went wrong';
    } catch (e) {
      print({'Error': e});
      return 'Bad response';
    }
  }

  void dispose() {
    _openAI.close();
  }
}
