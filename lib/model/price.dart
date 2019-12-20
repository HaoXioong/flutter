class PriceList {
  int status;
  String msg;
  List<Data> data;

  PriceList({this.status, this.msg, this.data});

  PriceList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String symbol;
  String close;

  Data({this.symbol, this.close});

  Data.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['close'] = this.close;
    return data;
  }
}
