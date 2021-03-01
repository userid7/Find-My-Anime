import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TraceModel {
  int rawDocsCount;
  int rawDocsSearchTime;
  int reRankSearchTime;
  bool cacheHit;
  int trial;
  int limit;
  int limitTtl;
  int quota;
  int quotaTtl;
  List<Docs> docs;

  TraceModel(
      {this.rawDocsCount,
      this.rawDocsSearchTime,
      this.reRankSearchTime,
      this.cacheHit,
      this.trial,
      this.limit,
      this.limitTtl,
      this.quota,
      this.quotaTtl,
      this.docs});

  TraceModel.fromJson(Map<String, dynamic> json) {
    rawDocsCount = json['RawDocsCount'];
    rawDocsSearchTime = json['RawDocsSearchTime'];
    reRankSearchTime = json['ReRankSearchTime'];
    cacheHit = json['CacheHit'];
    trial = json['trial'];
    limit = json['limit'];
    limitTtl = json['limit_ttl'];
    quota = json['quota'];
    quotaTtl = json['quota_ttl'];
    if (json['docs'] != null) {
      // ignore: deprecated_member_use
      docs = new List<Docs>();
      int id = 1;
      json['docs'].forEach((v) {
        docs.add(new Docs.fromJson(v, id));
        id++;
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RawDocsCount'] = this.rawDocsCount;
    data['RawDocsSearchTime'] = this.rawDocsSearchTime;
    data['ReRankSearchTime'] = this.reRankSearchTime;
    data['CacheHit'] = this.cacheHit;
    data['trial'] = this.trial;
    data['limit'] = this.limit;
    data['limit_ttl'] = this.limitTtl;
    data['quota'] = this.quota;
    data['quota_ttl'] = this.quotaTtl;
    if (this.docs != null) {
      data['docs'] = this.docs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Docs {
  int id;
  num from;
  num to;
  int anilistId;
  num at;
  dynamic season;
  String anime;
  String filename;
  dynamic episode;
  String tokenthumb;
  num similarity;
  String title;
  String titleNative;
  String titleChinese;
  String titleEnglish;
  String titleRomaji;
  int malId;
  List<String> synonyms;
  List<String> synonymsChinese;
  bool isAdult;

  double get percentage {
    return (this.similarity * 10000).truncateToDouble() / 100;
  }

  Color get percentageColor {
    if (this.percentage >= 86)
      return Colors.green[700];
    else if (this.percentage >= 80)
      return Colors.yellow[700];
    else if (this.percentage >= 75)
      return Colors.black;
    else
      return Colors.red;
  }

  double get opacity {
    if (this.percentage >= 86)
      return 1;
    else if (this.percentage >= 80)
      return 0.4;
    else if (this.percentage >= 75)
      return 0.2;
    else
      return 0.1;
  }

  Docs(
      {this.id,
      this.from,
      this.to,
      this.anilistId,
      this.at,
      this.season,
      this.anime,
      this.filename,
      this.episode,
      this.tokenthumb,
      this.similarity,
      this.title,
      this.titleNative,
      this.titleChinese,
      this.titleEnglish,
      this.titleRomaji,
      this.malId,
      this.synonyms,
      this.synonymsChinese,
      this.isAdult});

  Docs.fromJson(Map<String, dynamic> json, int docsId) {
    id = docsId;
    from = json['from'];
    to = json['to'];
    anilistId = json['anilist_id'];
    at = json['at'];
    season = json['season'];
    anime = json['anime'];
    filename = json['filename'];
    episode = json['episode'];
    tokenthumb = json['tokenthumb'];
    similarity = json['similarity'];
    title = json['title'];
    titleNative = json['title_native'];
    titleChinese = json['title_chinese'];
    titleEnglish = json['title_english'];
    titleRomaji = json['title_romaji'];
    malId = json['mal_id'];
    synonyms = json['synonyms'].cast<String>();
    synonymsChinese = json['synonyms_chinese'].cast<String>();
    isAdult = json['is_adult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['anilist_id'] = this.anilistId;
    data['at'] = this.at;
    data['season'] = this.season;
    data['anime'] = this.anime;
    data['filename'] = this.filename;
    data['episode'] = this.episode;
    data['tokenthumb'] = this.tokenthumb;
    data['similarity'] = this.similarity;
    data['title'] = this.title;
    data['title_native'] = this.titleNative;
    data['title_chinese'] = this.titleChinese;
    data['title_english'] = this.titleEnglish;
    data['title_romaji'] = this.titleRomaji;
    data['mal_id'] = this.malId;
    data['synonyms'] = this.synonyms;
    data['synonyms_chinese'] = this.synonymsChinese;
    data['is_adult'] = this.isAdult;
    return data;
  }

  String getTimestamp() {
    Duration _from = Duration(seconds: this.from.toInt());
    Duration _to = Duration(seconds: this.to.toInt());
    var _fromInString = _from.toString().split('.').first.padLeft(8, "0");
    var _toInString = _to.toString().split('.').first.padLeft(8, "0");
    return _fromInString + "-" + _toInString;
  }
}

final dummyResponse = {
  "RawDocsCount": 3555648,
  "RawDocsSearchTime": 14056,
  "ReRankSearchTime": 1182,
  "CacheHit": false,
  "trial": 1,
  "limit": 9,
  "limit_ttl": 60,
  "quota": 150,
  "quota_ttl": 86400,
  "docs": [
    {
      "from": 663.17,
      "to": 665.42,
      "anilist_id": 98444,
      "at": 665.08,
      "season": "2018-01",
      "anime": "搖曳露營",
      "filename": "[Ohys-Raws] Yuru Camp - 05 (AT-X 1280x720 x264 AAC).mp4",
      "episode": 5,
      "tokenthumb": "bB-8KQuoc6u-1SfzuVnDMw",
      "similarity": 0.9563952960290518,
      "title": "ゆるキャン△",
      "title_native": "ゆるキャン△",
      "title_chinese": "搖曳露營",
      "title_english": "Laid-Back Camp",
      "title_romaji": "Yuru Camp△",
      "mal_id": 34798,
      "synonyms": ["Yurucamp", "Yurukyan△"],
      "synonyms_chinese": [],
      "is_adult": false
    },
    {
      "from": 663.17,
      "to": 665.42,
      "anilist_id": 98444,
      "at": 665.08,
      "season": "2018-01",
      "anime": "搖曳露營",
      "filename": "[Ohys-Raws] Yuru Camp - 05 (AT-X 1280x720 x264 AAC).mp4",
      "episode": 5,
      "tokenthumb": "bB-8KQuoc6u-1SfzuVnDMw",
      "similarity": 0.9563952960290518,
      "title": "ゆるキャン△",
      "title_native": "ゆるキャン△",
      "title_chinese": "搖曳露營",
      "title_english": "Laid-Back Camp",
      "title_romaji": "Yuru Camp△",
      "mal_id": 34798,
      "synonyms": ["Yurucamp", "Yurukyan△"],
      "synonyms_chinese": [],
      "is_adult": false
    },
    {
      "from": 663.17,
      "to": 665.42,
      "anilist_id": 98444,
      "at": 665.08,
      "season": "2018-01",
      "anime": "搖曳露營",
      "filename": "[Ohys-Raws] Yuru Camp - 05 (AT-X 1280x720 x264 AAC).mp4",
      "episode": 5,
      "tokenthumb": "bB-8KQuoc6u-1SfzuVnDMw",
      "similarity": 0.9563952960290518,
      "title": "ゆるキャン△",
      "title_native": "ゆるキャン△",
      "title_chinese": "搖曳露營",
      "title_english": "Laid-Back Camp",
      "title_romaji": "Yuru Camp△",
      "mal_id": 34798,
      "synonyms": ["Yurucamp", "Yurukyan△"],
      "synonyms_chinese": [],
      "is_adult": false
    },
    {
      "from": 663.17,
      "to": 665.42,
      "anilist_id": 98444,
      "at": 665.08,
      "season": "2018-01",
      "anime": "搖曳露營",
      "filename": "[Ohys-Raws] Yuru Camp - 05 (AT-X 1280x720 x264 AAC).mp4",
      "episode": 5,
      "tokenthumb": "bB-8KQuoc6u-1SfzuVnDMw",
      "similarity": 0.9563952960290518,
      "title": "ゆるキャン△",
      "title_native": "ゆるキャン△",
      "title_chinese": "搖曳露營",
      "title_english": "Laid-Back Camp",
      "title_romaji": "Yuru Camp△",
      "mal_id": 34798,
      "synonyms": ["Yurucamp", "Yurukyan△"],
      "synonyms_chinese": [],
      "is_adult": false
    },
  ]
};
