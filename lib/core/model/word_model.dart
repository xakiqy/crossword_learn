class WordModel{
 final int id;
 final String word;
 final String? question, example;
 WordModel({required this.id, required this.word, required this.question, required this.example});

 factory WordModel.fromMap(Map<dynamic, dynamic> map) => WordModel(
  id : map['id'] as int,
  word : (map['word'] as String).trim().toLowerCase(),
  question : map['question'] as String?,
  example : map['example'] as String?);

}