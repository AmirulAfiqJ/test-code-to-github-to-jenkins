class sptotalsubscribers {
  String? status;
  String? date;
  SpecificTotalSubscribers? specificTotalSubscribers;

  sptotalsubscribers({this.status, this.date, this.specificTotalSubscribers});

  sptotalsubscribers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    date = json['date'];
    specificTotalSubscribers = json['specific-total-subscribers'] != null
        ? new SpecificTotalSubscribers.fromJson(
            json['specific-total-subscribers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['date'] = this.date;
    if (this.specificTotalSubscribers != null) {
      data['specific-total-subscribers'] =
          this.specificTotalSubscribers!.toJson();
    }
    return data;
  }
}

class SpecificTotalSubscribers {
  int? bASICThisMonth;
  int? bASICThisYear;
  int? pRIVILLEGE6ThisYear;
  int? pROThisYear;
  int? sUPERB12ThisYear;
  int? uLTIMATE1ThisMonth;
  int? uLTIMATE1ThisYear;
  int? uLTIMATE12ThisMonth;
  int? uLTIMATE12ThisYear;
  int? uLTIMATE6ThisYear;
  int? uLTRAThisYear;

  SpecificTotalSubscribers(
      {this.bASICThisMonth,
      this.bASICThisYear,
      this.pRIVILLEGE6ThisYear,
      this.pROThisYear,
      this.sUPERB12ThisYear,
      this.uLTIMATE1ThisMonth,
      this.uLTIMATE1ThisYear,
      this.uLTIMATE12ThisMonth,
      this.uLTIMATE12ThisYear,
      this.uLTIMATE6ThisYear,
      this.uLTRAThisYear});

  SpecificTotalSubscribers.fromJson(Map<String, dynamic> json) {
    bASICThisMonth = json['BASIC+|this_month'];
    bASICThisYear = json['BASIC+|this_year'];
    pRIVILLEGE6ThisYear = json['PRIVILLEGE6|this_year'];
    pROThisYear = json['PRO|this_year'];
    sUPERB12ThisYear = json['SUPERB12|this_year'];
    uLTIMATE1ThisMonth = json['ULTIMATE1|this_month'];
    uLTIMATE1ThisYear = json['ULTIMATE1|this_year'];
    uLTIMATE12ThisMonth = json['ULTIMATE12|this_month'];
    uLTIMATE12ThisYear = json['ULTIMATE12|this_year'];
    uLTIMATE6ThisYear = json['ULTIMATE6|this_year'];
    uLTRAThisYear = json['ULTRA|this_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BASIC+|this_month'] = this.bASICThisMonth;
    data['BASIC+|this_year'] = this.bASICThisYear;
    data['PRIVILLEGE6|this_year'] = this.pRIVILLEGE6ThisYear;
    data['PRO|this_year'] = this.pROThisYear;
    data['SUPERB12|this_year'] = this.sUPERB12ThisYear;
    data['ULTIMATE1|this_month'] = this.uLTIMATE1ThisMonth;
    data['ULTIMATE1|this_year'] = this.uLTIMATE1ThisYear;
    data['ULTIMATE12|this_month'] = this.uLTIMATE12ThisMonth;
    data['ULTIMATE12|this_year'] = this.uLTIMATE12ThisYear;
    data['ULTIMATE6|this_year'] = this.uLTIMATE6ThisYear;
    data['ULTRA|this_year'] = this.uLTRAThisYear;
    return data;
  }
}
