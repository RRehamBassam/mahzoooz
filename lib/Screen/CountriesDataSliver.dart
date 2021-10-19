//
// import 'package:flutter/material.dart';
// import 'package:mahzoooz/Screen/NetworkingPageContent.dart';
// import 'package:mahzoooz/Screen/NetworkingPageHeader.dart';
// class CountriesDataSliver extends StatelessWidget {
//   var data;
//
//   CountriesDataSliver(this.data);
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverPersistentHeader(
//             pinned: false,
//             floating: true,
//             delegate: NetworkingPageHeader(
//               data: data,
//               minExtent: 150.0,
//               maxExtent: 250.0,
//             ),
//           ),
//           NetworkingPageContent(),
//           // SliverFillRemaining(
//           //   child: Center(
//           //     child: Text(
//           //       'No Content',
//           //       style: Theme.of(context).textTheme.headline,
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
//
//
// }
//
