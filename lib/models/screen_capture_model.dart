class ScreenCaptureModel {
  final String takeSSTracEnable;
  final String ssInterval;
  final String randomizeSSInterval;
  final String blurSS;

  ScreenCaptureModel({
    required this.takeSSTracEnable,
    required this.ssInterval,
    required this.randomizeSSInterval,
    required this.blurSS,
  });

  Map<String, dynamic> toJson() {
    return {
      'takeSSTracEnable': takeSSTracEnable,
      'ssInterval': ssInterval,
      'randomizeSSInterval': randomizeSSInterval,
      'blurSS': blurSS,
    };
  }

  factory ScreenCaptureModel.fromJson(Map<String, dynamic> json) {
    return ScreenCaptureModel(
      takeSSTracEnable: json['takeSSTracEnable'],
      ssInterval: json['ssInterval'],
      randomizeSSInterval: json['randomizeSSInterval'],
      blurSS: json['blurSS'],
    );
  }
}
