class ClassifyModel
{
  final String label;
  final double confidence;

  ClassifyModel({required this.label, required this.confidence});

  factory ClassifyModel.fromMap(Map<dynamic, dynamic> json)
  {
    return ClassifyModel(
      label: json['label'],
      confidence: json['confidence'],
    );
  }
}