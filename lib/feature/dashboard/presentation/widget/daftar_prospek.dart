import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/routes/app_route.dart';
import 'package:mam/feature/dashboard/model/daftar_prospek_model.dart';

class DaftarProspekWidget extends StatelessWidget {
  final List<DaftarProspekModel> prospekList;

  const DaftarProspekWidget({super.key, required this.prospekList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
      ),
      child: SizedBox(
        height: 590, // Set a fixed height for the ListView
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: prospekList.length,
          itemBuilder: (context, index) {
            final daftarProspek = prospekList[index];
            return GestureDetector(
              onTap: () {
                context.push(AppRoutePaths.detailprospek, extra: daftarProspek);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: index == 0
                      ? 0.0
                      : 5.0, // No top padding for the first item
                  bottom: index == prospekList.length - 1
                      ? 0.0
                      : 5.0, // No bottom padding for the last item
                ),
                child: Card(
                  color: AppColor.cardColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                daftarProspek.title,
                                style: const TextStyle(
                                  fontSize:
                                      15.0, // Set the maximum font size to 15
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1, // Limit the text to a single line
                                overflow: TextOverflow
                                    .ellipsis, // Use ellipsis to indicate overflow
                              ),
                              Text(
                                daftarProspek.description,
                                style: const TextStyle(
                                  fontSize:
                                      8.0, // Set the maximum font size to 15
                                ),
                                maxLines: 1, // Limit the text to a single line
                                overflow: TextOverflow
                                    .ellipsis, // Use ellipsis to indicate overflow
                              )
                            ],
                          ),
                          SizedBox(height: 10), // Space between rows
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${daftarProspek.date.toLocal()}'),
                              Text(daftarProspek.location),
                            ],
                          ),
                          SizedBox(height: 10), // Space between rows
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(daftarProspek.organizer),
                              Text(daftarProspek.isCompleted),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
