import 'package:flutter/material.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/feature/dashboard/model/informasi_model.dart';

class InformasiWidget extends StatelessWidget {
  final List<InformasiModel> informasiList;

  const InformasiWidget({super.key, required this.informasiList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
      ),
      child: SizedBox(
        height: 140, // Set a fixed height for the ListView
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(0),
          itemCount: informasiList.length,
          itemBuilder: (context, index) {
            final informasi = informasiList[index];
            return Padding(
              padding: EdgeInsets.only(
                left:
                    index == 0 ? 0.0 : 5.0, // No top padding for the first item
                right: index == informasiList.length - 1
                    ? 0.0
                    : 10.0, // No bottom padding for the last item
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
                              informasi.title,
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
                              informasi.description,
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
                            Text('${informasi.date.toLocal()}'),
                            Text(informasi.location),
                          ],
                        ),
                        SizedBox(height: 10), // Space between rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(informasi.organizer),
                            Text(informasi.isCompleted),
                          ],
                        ),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
