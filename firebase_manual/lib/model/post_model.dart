class Post {
  final String? post;
  final String? imageName;
  final String? uploadUrl;

  Post({this.post, this.imageName, this.uploadUrl});

  //not used since we are not recieving data from firebase
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      post: json["post"],
      imageName: json["imageName"],
      uploadUrl: json["uploadUrl"],
    );
  }

  //Used to model upload data to firebase
  Map<String, dynamic> toJson() {
    return {
      "post": post,
      "imageName": imageName,
      "uploadUrl": uploadUrl,
    };
  }
}
