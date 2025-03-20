import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/routes/app_route.dart';
import 'package:mam/feature/dashboard/model/aktivitas_hari_ini_model.dart';

class AktivitasHariIniWidget extends StatelessWidget {
  final List<AktivitasHariIniModel> aktivitasList;

  const AktivitasHariIniWidget({super.key, required this.aktivitasList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: 590,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: aktivitasList.length,
          itemBuilder: (context, index) {
            final aktivitas = aktivitasList[index];
            return GestureDetector(
              onTap: () {
                context.push(AppRoutePaths.detailaktivitas, extra: aktivitas);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 0.0 : 5.0,
                  bottom: index == aktivitasList.length - 1 ? 0.0 : 5.0,
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
                              aktivitas.title,
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              aktivitas.description,
                              style: const TextStyle(fontSize: 8.0),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(aktivitas.formattedDate),
                            Text(aktivitas.location),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(aktivitas.organizer),
                            Text(aktivitas.time),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
