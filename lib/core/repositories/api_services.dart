import 'dart:developer';
import 'dart:io';
import 'package:genrative_ai/core/constants/api_constant.dart';
import 'package:genrative_ai/core/model/chat_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GoogleGenerativeServices {
  // late GenerativeModel _gemini;
  // static final GoogleGenerativeServices _instance = GoogleGenerativeServices._internal();
  // factory GoogleGenerativeServices() {
  //   return _instance;
  // }
  // GoogleGenerativeServices._internal() {
  //   _gemini = GenerativeModel.instance;
  // }
  Future<String> getText(String message) async {
    String result = '';
    try {
      final model =
          GenerativeModel(model: 'gemini-pro', apiKey: ApiConstant.apiToken);
      final prompts = message;
      final content = [Content.text(prompts)];
      final response = await model.generateContent(content);
      result = response.text ?? '';
      return result;
    } catch (e) {
      log("Error is $e");
    }
    return '';
  }

  Future<ChatModel?> getTextFromImage(File photo, String message) async {
    try {
      final model = GenerativeModel(
          model: 'gemini-1.5-flash', apiKey: ApiConstant.apiToken);

      final prompt = TextPart(message);
      final imageParts = [
        DataPart('image/jpeg', await photo.readAsBytes()),
      ];
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);
      log(response.text.toString());
      return ChatModel(
          role: response.candidates.first.content.role.toString(),
          text: response.text.toString());
    } catch (e) {
      log("Error is $e");
    }
    return null;
  }
}
