class Ratings {
  Ratings({
    this.oneStar,
    this.twoStar,
    this.threeStar,
    this.fourStar,
    this.fiveStar,
    this.average,
  });

  StarRatingDetails? oneStar, twoStar, threeStar, fourStar, fiveStar;
  var average;

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        oneStar: json["1"] == null
            ? StarRatingDetails()
            : StarRatingDetails.fromJson(json["1"]),
        twoStar: json["2"] == null
            ? StarRatingDetails()
            : StarRatingDetails.fromJson(json["2"]),
        threeStar: json["3"] == null
            ? StarRatingDetails()
            : StarRatingDetails.fromJson(json["3"]),
        fourStar: json["4"] == null
            ? StarRatingDetails()
            : StarRatingDetails.fromJson(json["4"]),
        fiveStar: json["5"] == null
            ? StarRatingDetails()
            : StarRatingDetails.fromJson(json["5"]),
        average: json["average"],
      );

  Map<String, dynamic> toJson() => {
        "1": oneStar?.toJson(),
        "2": twoStar?.toJson(),
        "3": oneStar == null ? null : threeStar!.toJson(),
        "4": twoStar == null ? null : fourStar!.toJson(),
        "5": twoStar == null ? null : fiveStar!.toJson(),
        "average": average,
      };
}

class StarRatingDetails {
  StarRatingDetails({
    this.count,
    this.feedbackIds,
  });

  int? count;
  List<String>? feedbackIds;

  factory StarRatingDetails.fromJson(Map<String, dynamic> json) =>
      StarRatingDetails(
        count: json["count"] ?? 0,
        feedbackIds: json["feedbackIds"] == null
            ? "" as List<String>?
            : List<String>.from(json["feedbackIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "feedbackIds": feedbackIds == null
            ? null
            : List<dynamic>.from(feedbackIds!.map((x) => x)),
      };
}
