class activeuser {
  String? reportDate;
  ResultData? resultData;

  activeuser({this.reportDate, this.resultData});

  activeuser.fromJson(Map<String, dynamic> json) {
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
  TotalActiveUser? totalActiveUser;

  ResultData({this.status, this.totalActiveUser});

  ResultData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalActiveUser = json['total-active-user'] != null
        ? new TotalActiveUser.fromJson(json['total-active-user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.totalActiveUser != null) {
      data['total-active-user'] = this.totalActiveUser!.toJson();
    }
    return data;
  }
}

class TotalActiveUser {
  int? today;
  int? yesterday;
  int? thisWeek;
  int? thisMonth;
  int? thisYear;

  TotalActiveUser(
      {this.today,
      this.yesterday,
      this.thisWeek,
      this.thisMonth,
      this.thisYear});

  TotalActiveUser.fromJson(Map<String, dynamic> json) {
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
