import 'dart:convert';

import '../../../util/utility.dart';

class OfflineController {

  Future<List<String>> getFormsOnLocal(String formType) async {
    String forms = await Utility.getLocalStorage(formType);
    if (forms == null) return [];
    return json.decode(forms).map<String>( (f) => f.toString() ).toList();
  }

  addFormsOnLocal(String formType, String formId) async {
    List<String> current = await getFormsOnLocal(formType);
    current.add(formId);
    await Utility.setLocalStorage(formType, json.encode(current));
  }

  removeFormsOnLocal(String formType, String formId) async {
    List<String> current = await getFormsOnLocal(formType);
    current.remove(formId);
    await Utility.setLocalStorage(formType, json.encode(current));
  }

  Future<String> saveToLocalStorage(String formType, String data) async {
    String formId = (new DateTime.now().millisecondsSinceEpoch).toString();
    await Utility.setLocalStorage(formId, data);
    await addFormsOnLocal(formType, formId);
    return formId;
  }

}