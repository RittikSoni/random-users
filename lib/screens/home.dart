import 'package:by_rittik/screens/user_detail.dart';
import 'package:by_rittik/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:by_rittik/models/users_model.dart';
import 'package:by_rittik/network/api_serices.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _pageSize = 6;

  final PagingController<int, UsersData> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await APiServices().getUsers(pageKey);
      final isLastPage = newItems.data!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems.data!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView<int, UsersData>(
        shrinkWrap: true,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<UsersData>(
          noMoreItemsIndicatorBuilder: (context) => const Row(
            children: [
              Expanded(
                child: Divider(
                  endIndent: 10.0,
                  color: Colors.black,
                ),
              ),
              Text('End of list'),
              Expanded(
                child: Divider(
                  indent: 10.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          itemBuilder: (context, item, index) => ListTile(
            onTap: () {
              CustomRoute().push(
                context: context,
                page: UserDetails(
                  userId: item.id!,
                ),
              );
            },
            isThreeLine: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.id.toString()),
                const SizedBox(
                  width: 10.0,
                ),
                Text(item.firstName.toString()),
                Text(item.lastName.toString()),
              ],
            ),
            leading: Hero(
              tag: item.id.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  item.avatar.toString(),
                ),
              ),
            ),
            subtitle: Text(item.email.toString()),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
