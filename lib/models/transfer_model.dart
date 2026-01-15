import 'dart:convert';

import 'package:v_wallet_frontend/models/transaction_type.dart';

TransferModel transferModelFromJson(String str) =>
    TransferModel.fromJson(json.decode(str));

String transferModelToJson(TransferModel data) => json.encode(data.toJson());

class TransferModel {
  List<Datum> data;
  Links? links;
  Meta? meta;

  TransferModel({required this.data, required this.links, required this.meta});

  factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Datum {
  String id;
  int amount;
  String status;
  String date;
  TransactionType transactionType;
  String participant;
  Receiver sender;
  Receiver receiver;

  Datum({
    required this.id,
    required this.amount,
    required this.status,
    required this.date,
    required this.transactionType,
    required this.participant,
    required this.sender,
    required this.receiver,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    amount: json["amount"],
    status: json["status"],
    date: json["date"],
    transactionType: TransactionType.getTransactionType(
      json["transaction_type"],
    ),
    participant: json["participant"],
    sender: Receiver.fromJson(json["sender"]),
    receiver: Receiver.fromJson(json["receiver"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "status": status,
    "date": date,
    "transaction_type": transactionType,
    "participant": participant,
    "sender": sender.toJson(),
    "receiver": receiver.toJson(),
  };
}

class Receiver {
  int id;
  String name;
  String phone;
  int balance;
  DateTime createdAt;
  DateTime updatedAt;

  Receiver({
    required this.id,
    required this.name,
    required this.phone,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    balance: json["balance"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "balance": balance,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Links {
  String first;
  String last;
  dynamic prev;
  String? next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  int? page;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.page,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    page: json["page"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "page": page,
    "active": active,
  };
}
