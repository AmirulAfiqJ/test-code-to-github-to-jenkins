class bizappage {
  String? id;
  String? pid;
  String? salespageid;
  String? salespagename;
  String? url;

  bizappage(
      {this.id, this.pid, this.salespageid, this.salespagename, this.url});

  bizappage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    salespageid = json['salespageid'];
    salespagename = json['salespagename'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['salespageid'] = this.salespageid;
    data['salespagename'] = this.salespagename;
    data['url'] = this.url;
    return data;
  }
}
