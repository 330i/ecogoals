class WebResult {
  final List<String> titles;
  final List<String> urls;

  WebResult({this.titles, this.urls});

  factory WebResult.fromJson(List<dynamic> json) {
    return WebResult(
      titles: json[0].cast<String>(),
      urls: json[1].cast<String>(),
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return titles.toString() + " " + urls.toString();
  }
}
