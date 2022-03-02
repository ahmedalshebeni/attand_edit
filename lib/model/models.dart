class Payload {
  List<Datum> data;

  Payload({
    this.data,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  // ignore: non_constant_identifier_names
  String shift_id;
  // ignore: non_constant_identifier_names
  String shift_name;

  Datum({
    // ignore: non_constant_identifier_names
    this.shift_id,
    // ignore: non_constant_identifier_names
    this.shift_name,
    // ignore: non_constant_identifier_names

  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    shift_id:json['shift_id'],
    shift_name:json['shift_name'],

  );

  Map<String, dynamic> toJson() => {
    "shift_id":"$shift_id",
    "shift_name":"$shift_name",
  };
}

class Album {
  // ignore: non_constant_identifier_names
  final int emp_id;
  // ignore: non_constant_identifier_names
  final DateTime work_date;
  // ignore: non_constant_identifier_names
  final int work_type;
  // ignore: non_constant_identifier_names
  final String start_time;
  // ignore: non_constant_identifier_names
  final String end_time;
  // ignore: non_constant_identifier_names
  final String shift_id;
  // ignore: non_constant_identifier_names
  String shift_name;
  Album(
      // ignore: non_constant_identifier_names
          {this.emp_id,
        // ignore: non_constant_identifier_names
        this.work_date,
        // ignore: non_constant_identifier_names
        this.work_type,
        // ignore: non_constant_identifier_names
        this.start_time,
        // ignore: non_constant_identifier_names
        this.end_time,
        // ignore: non_constant_identifier_names
        this.shift_id,
        // ignore: non_constant_identifier_names
        this.shift_name,
      }
      );

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      emp_id: json['emp_id'],
      work_date: json['work_date'],
      work_type: json['work_type'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      shift_id: json['shift_id'],
      shift_name:json['shift_name'],
    );
  }
}

class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      emp_id:json['emp_id']??'0',
      work_date: json['work_date']??'0',
      work_type: json['work_type']??'0',
      start_time: json['start_time']??'0',
      end_time: json['end_time']??"0",
      shift_id: json['shift_id']??'0',
      created_user:json['created_user']??'0',
      created_date: json['created_date']??'0',
      changed_user:json['changed_user']??'0',
      changed_date: json['changed_date']??'0',
      // wfl_approve_flag: json['wfl_approve_flag']??"",shift_id
    );
  }
  Product(
      {
        // ignore: non_constant_identifier_names
        this.emp_id,
        // ignore: non_constant_identifier_names
        this.work_date,
        // ignore: non_constant_identifier_names
        this.work_type,
        // ignore: non_constant_identifier_names
        this.start_time,
        // ignore: non_constant_identifier_names
        this.end_time,
        // ignore: non_constant_identifier_names
        this.shift_id,
        // ignore: non_constant_identifier_names
        this.created_user,
        // ignore: non_constant_identifier_names
        this.created_date,
        // ignore: non_constant_identifier_names
        this.changed_user,
        // ignore: non_constant_identifier_names
        this.changed_date,
      });
  // ignore: non_constant_identifier_names
  final String emp_id;
  // ignore: non_constant_identifier_names
  final String work_date;
  // ignore: non_constant_identifier_names
  final String work_type;
  // ignore: non_constant_identifier_names
  final String start_time;
  // ignore: non_constant_identifier_names
  final String end_time;
  // ignore: non_constant_identifier_names
  final String shift_id;
  // ignore: non_constant_identifier_names
  final String created_user;
  // ignore: non_constant_identifier_names
  final String created_date;
  // ignore: non_constant_identifier_names
  final String changed_user;
  // ignore: non_constant_identifier_names
  final String changed_date;

}