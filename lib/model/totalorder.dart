class totalorder {
  String? reportDate;
  ResultData? resultData;

  totalorder({this.reportDate, this.resultData});

  totalorder.fromJson(Map<String, dynamic> json) {
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
  TotalOrders? totalOrders;

  ResultData({this.status, this.totalOrders});

  ResultData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalOrders = json['total-orders'] != null
        ? new TotalOrders.fromJson(json['total-orders'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.totalOrders != null) {
      data['total-orders'] = this.totalOrders!.toJson();
    }
    return data;
  }
}

class TotalOrders {
  int? today;
  int? yesterday;
  int? thisWeek;
  int? thisMonth;
  int? thisYear;

  TotalOrders(
      {this.today,
      this.yesterday,
      this.thisWeek,
      this.thisMonth,
      this.thisYear});

  TotalOrders.fromJson(Map<String, dynamic> json) {
    today = json['today'];
    yesterday = json['yesterday'];
    thisWeek = json['this_week'];
    thisMonth = json['this_month'];
    thisYear = json['this_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today'] = this.today;
    data['yesterday'] = this.yesterday;
    data['this_week'] = this.thisWeek;
    data['this_month'] = this.thisMonth;
    data['this_year'] = this.thisYear;
    return data;
  }
}
