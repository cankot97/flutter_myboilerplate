
class BodyPart {
  final String? name;
  final double? x1;
  final double? x2;
  final double? y1;
  final double? y2;
  final int? userId;
  final int? id;
  final String? title;

  const BodyPart({ this.name,  this.x1,
   this.x2,  this.y1,  this.y2, this.userId,  this.id,this.title});

  factory BodyPart.fromJson(Map<String, dynamic> json) {
    return BodyPart(
      userId: json['userID'],
      id: json['id'],
      title: json['title'],
    );
  }

  bool isBodyPart(x, y){
    if (x >= x1 && x<= x2 && y >= y1 && y <= y2 ){
      return true;
    }
    return false;
  }
}

BodyPart head = const BodyPart(name: 'head', x1: 166, x2: 226, y1: 7, y2: 85,id: 1);

BodyPart lhand = const BodyPart(name: 'left hand', x1: 70, x2: 100, y1: 125, y2: 340, id: 2);

final bodyparts =  [head, lhand];