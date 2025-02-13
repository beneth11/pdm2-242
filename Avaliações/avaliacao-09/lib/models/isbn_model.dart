class IsbnModel {
  String? isbn;
  String? title;
  Null subtitle;
  List<String>? authors;
  String? publisher;
  String? synopsis;
  Null dimensions;
  int? year;
  String? format;
  int? pageCount;
  List<String>? subjects;
  String? location;
  Null retailPrice;
  Null coverUrl;
  String? provider;

  IsbnModel(
      {this.isbn,
      this.title,
      this.subtitle,
      this.authors,
      this.publisher,
      this.synopsis,
      this.dimensions,
      this.year,
      this.format,
      this.pageCount,
      this.subjects,
      this.location,
      this.retailPrice,
      this.coverUrl,
      this.provider});

  IsbnModel.fromJson(Map<String, dynamic> json) {
    isbn = json['isbn'];
    title = json['title'];
    subtitle = json['subtitle'];
    authors = json['authors'].cast<String>();
    publisher = json['publisher'];
    synopsis = json['synopsis'];
    dimensions = json['dimensions'];
    year = json['year'];
    format = json['format'];
    pageCount = json['page_count'];
    subjects = json['subjects'].cast<String>();
    location = json['location'];
    retailPrice = json['retail_price'];
    coverUrl = json['cover_url'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isbn'] = isbn;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['authors'] = authors;
    data['publisher'] = publisher;
    data['synopsis'] = synopsis;
    data['dimensions'] = dimensions;
    data['year'] = year;
    data['format'] = format;
    data['page_count'] = pageCount;
    data['subjects'] = subjects;
    data['location'] = location;
    data['retail_price'] = retailPrice;
    data['cover_url'] = coverUrl;
    data['provider'] = provider;
    return data;
  }
}
