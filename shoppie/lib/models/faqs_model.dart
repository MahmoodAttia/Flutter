class FAQ {
  bool? status;
  Data? data;

  FAQ.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<FaqData>? data;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(FaqData.fromJson(v));
      });
    }
  }
}

class FaqData {
  int? id;
  String? question;
  String? answer;

  FaqData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}
