import 'package:by_rittik/models/user_details_model.dart';
import 'package:by_rittik/network/api_serices.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({required this.userId, super.key});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('User Details'),
        centerTitle: true,
      ),
      body: FutureBuilder<UserDetailModel>(
        future: APiServices().getUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong.\n ${snapshot.error}');
          } else if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          const textStyle =
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: snapshot.data!.data!.id.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.network(
                    snapshot.data!.data!.avatar.toString(),
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${snapshot.data!.data!.id} ${snapshot.data!.data!.firstName}',
                    style: textStyle,
                  ),
                  Text(
                    snapshot.data!.data!.lastName.toString(),
                    style: textStyle,
                  ),
                ],
              ),
              Text(snapshot.data!.data!.email.toString()),
            ],
          );
        },
      ),
    );
  }
}
