class totalsubscribers {
  String? reportDate;
  ResultData? resultData;

  totalsubscribers({this.reportDate, this.resultData});

  totalsubscribers.fromJson(Map<String, dynamic> json) {
    reportDate = json['report_date'];
    resultData = json['resultData'] != null
        ? new ResultData.fromJson(json['resultData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_date'] = this.reportDate;
    if (this.resultData != null) {
      data['resultData'] = this.resultData!.toJson();
    }
    return data;
  }
}

class ResultData {
  String? status;
  TotalSubscribers? totalSubscribers;

  ResultData({this.status, this.totalSubscribers});

  ResultData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalSubscribers = json['total-subscribers'] != null
        ? new TotalSubscribers.fromJson(json['total-subscribers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.totalSubscribers != null) {
      data['total-subscribers'] = this.totalSubscribers!.toJson();
    }
    return data;
  }
}

class TotalSubscribers {
  int? bASICThisMonth;
  int? bASICThisWeek;
  int? bASICThisYear;
  int? bASICToday;
  int? bASICYesterday;
  int? pRIVILLEGE6ThisYear;
  int? pROThisYear;
  int? sUPERB12ThisYear;
  int? uLTIMATE1ThisWeek;
  int? uLTIMATE1ThisYear;
  int? uLTIMATE1Today;
  int? uLTIMATE1Yesterday;
  int? uLTIMATE12ThisMonth;
  int? uLTIMATE12ThisWeek;
  int? uLTIMATE12ThisYear;
  int? uLTIMATE12Yesterday;
  int? uLTIMATE6ThisYear;
  int? uLTRAThisYear;

  TotalSubscribers(
      {this.bASICThisMonth,
      this.bASICThisWeek,
      this.bASICThisYear,
      this.bASICToday,
      this.bASICYesterday,
      this.pRIVILLEGE6ThisYear,
      this.pROThisYear,
      this.sUPERB12ThisYear,
      this.uLTIMATE1ThisWeek,
      this.uLTIMATE1ThisYear,
      this.uLTIMATE1Today,
      this.uLTIMATE1Yesterday,
      this.uLTIMATE12ThisMonth,
      this.uLTIMATE12ThisWeek,
      this.uLTIMATE12ThisYear,
      this.uLTIMATE12Yesterday,
      this.uLTIMATE6ThisYear,
      this.uLTRAThisYear});

  TotalSubscribers.fromJson(Map<String, dynamic> json) {
    bASICThisMonth = json['BASIC+|this_month'];
    bASICThisWeek = json['BASIC+|this_week'];
    bASICThisYear = json['BASIC+|this_year'];
    bASICToday = json['BASIC+|today'];
    bASICYesterday = json['BASIC+|yesterday'];
    pRIVILLEGE6ThisYear = json['PRIVILLEGE6|this_year'];
    pROThisYear = json['PRO|this_year'];
    sUPERB12ThisYear = json['SUPERB12|this_year'];
    uLTIMATE1ThisWeek = json['ULTIMATE1|this_week'];
    uLTIMATE1ThisYear = json['ULTIMATE1|this_year'];
    uLTIMATE1Today = json['ULTIMATE1|today'];
    uLTIMATE1Yesterday = json['ULTIMATE1|yesterday'];
    uLTIMATE12ThisMonth = json['ULTIMATE12|this_month'];
    uLTIMATE12ThisWeek = json['ULTIMATE12|this_week'];
    uLTIMATE12ThisYear = json['ULTIMATE12|this_year'];
    uLTIMATE12Yesterday = json['ULTIMATE12|yesterday'];
    uLTIMATE6ThisYear = json['ULTIMATE6|this_year'];
    uLTRAThisYear = json['ULTRA|this_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BASIC+|this_month'] = this.bASICThisMonth;
    data['BASIC+|this_week'] = this.bASICThisWeek;
    data['BASIC+|this_year'] = this.bASICThisYear;
    data['BASIC+|today'] = this.bASICToday;
    data['BASIC+|yesterday'] = this.bASICYesterday;
    data['PRIVILLEGE6|this_year'] = this.pRIVILLEGE6ThisYear;
    data['PRO|this_year'] = this.pROThisYear;
    data['SUPERB12|this_year'] = this.sUPERB12ThisYear;
    data['ULTIMATE1|this_week'] = this.uLTIMATE1ThisWeek;
    data['ULTIMATE1|this_year'] = this.uLTIMATE1ThisYear;
    data['ULTIMATE1|today'] = this.uLTIMATE1Today;
    data['ULTIMATE1|yesterday'] = this.uLTIMATE1Yesterday;
    data['ULTIMATE12|this_month'] = this.uLTIMATE12ThisMonth;
    data['ULTIMATE12|this_week'] = this.uLTIMATE12ThisWeek;
    data['ULTIMATE12|this_year'] = this.uLTIMATE12ThisYear;
    data['ULTIMATE12|yesterday'] = this.uLTIMATE12Yesterday;
    data['ULTIMATE6|this_year'] = this.uLTIMATE6ThisYear;
    data['ULTRA|this_year'] = this.uLTRAThisYear;
    return data;
  }
}
