import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home/common/widgets/Widget/Profile/CreateProfile.dart';
import 'package:smart_home/models/UserProfileModel.dart';
import 'package:smart_home/utils/local_storage.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  // User? user = FirebaseAuth.instance.currentUser;
  // UserProfileModel loggedInUser = UserProfileModel();
  // string for displaying the error Message
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // var userId = LocalStorage.getString(LocalStorageKey.userId);
    // print("userId $userId");
    // print("userId 1 ${user}");
    // FirebaseFirestore.instance
    //     .collection("profileUsers")
    //     .doc(userId)
    //     .get()
    //     .then((value) {
    //   print("Value: ${value.data}");
    //   loggedInUser = UserProfileModel.fromMap(value.data);
    //   setState(() {});
    // });
  }

  Widget build(BuildContext context) {
    // var urlImage;
    // urlImage = loggedInUser.image;

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xEAF88325),
                Color(0xFFE87114),
              ],
              begin: FractionalOffset(0.0, 1.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              // tileMode: TileMode.clamp
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    "Thông tin cá nhân",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                  height: 800,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40))),
                  child: Container(
                      child: SingleChildScrollView(
                    child: SizedBox(
                      height: 900,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    height: 130,
                                    width: 130,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      clipBehavior: Clip.none,
                                      children: [
                                        if (LocalStorage.getString(
                                                LocalStorageKey.avatar)
                                            .isEmpty)
                                          Container(
                                              width: 110,
                                              height: 110,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.red),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                              child: Icon(Icons.image,
                                                  size: 60,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        if (LocalStorage.getString(
                                                LocalStorageKey.avatar)
                                            .isNotEmpty)
                                          CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  LocalStorage.getString(
                                                      LocalStorageKey.avatar))),
                                      ],
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 30),
                                                    child: const Text(
                                                        "Họ và tên:",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  Text(
                                                      "${LocalStorage.getString(LocalStorageKey.fullname)} ",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 19,
                                                      )),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 30),
                                                    child: const Text("Email:",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  Text(
                                                      "${LocalStorage.getString(LocalStorageKey.email)} ",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 19,
                                                      )),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 30),
                                                    child: const Text(
                                                        "Điện thoại:",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  Text(
                                                    // "${LocalStorage.getString(LocalStorageKey.mobile)} ",
                                                    "${LocalStorage.getString(LocalStorageKey.mobile).isNotEmpty ? LocalStorage.getString(LocalStorageKey.mobile) : "Chưa cập nhật..."} ",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 30),
                                                    child: const Text(
                                                        "Địa chỉ:",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  Text(
                                                    "${LocalStorage.getString(LocalStorageKey.address).isNotEmpty ? LocalStorage.getString(LocalStorageKey.address) : "Chưa cập nhật..."} ",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: <Widget>[
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 30),
                                                    child: const Text("CCCD",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  Text(
                                                    // "${LocalStorage.getString(LocalStorageKey.username)} ",
                                                    "${LocalStorage.getString(LocalStorageKey.identify).isNotEmpty ? LocalStorage.getString(LocalStorageKey.identify) : "Chưa cập nhật..."} ",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 35),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  )))
            ],
          ),
        ),
      ),
    ));
  }
}
