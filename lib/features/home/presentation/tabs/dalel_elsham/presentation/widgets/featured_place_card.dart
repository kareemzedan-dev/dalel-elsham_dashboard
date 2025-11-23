import 'package:dlyl_alsham_dashboard/core/components/contact_button_card.dart';
import 'package:dlyl_alsham_dashboard/core/services/phone_call_service.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/dalel_elsham/domain/entities/dalel_al_sham_place_entity.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/widgets/banner_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/services/contact_launcher_service.dart';
import '../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../core/utils/colors_manager.dart';
import '../../../home/domain/entities/banner_entity.dart';
import '../../data/model/dalel_al_sham_place_model.dart';
import '../manager/add_place_view_model/add_place_view_model.dart';
import '../manager/delete_place_view_model/delete_place_view_model.dart';
import '../manager/delete_place_view_model/delete_place_view_model_states.dart';
import '../manager/update_place_view_model/update_place_view_model.dart';
import 'add_place_sheet.dart';

class FeaturedPlaceCard extends StatelessWidget {
  const FeaturedPlaceCard({super.key, required this.place});

  final DalelAlShamPlaceEntity place;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2.w),
          borderRadius: BorderRadius.circular(12.r),
          color: ColorsManager.grey.withOpacity(0.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// زر التعديل والحذف
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.more_vert, size: 22.sp),
                    onPressed: () => _showPlaceMenu(context, place),
                  ),
                ],
              ),

              /// الصور
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: BannerSection(
                  showDotsOnTop: true,
                  disableAutoPlay: true,
                  images: place.images.map((img) {
                    return BannerEntity(
                      id: UniqueKey().toString(),
                      imageUrl: img,
                      type: "",
                      link: null,
                      projectId: null,
                      places: ["dalel_al_sham"],
                      isActive: true,
                      order: 0,
                      createdAt: DateTime.now(),
                    );
                  }).toList(),
                ),
              ),

              /// المحتوى النصي
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),

                          Text(
                            place.description,
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              fontSize: 14.sp,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 16.sp),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  place.addressText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Row(
                      children: [
                        ContactButtonCard(
                          image: AssetsManager.phoneCall,
                          onTap: () {
                            PhoneCallService.callNumber(place.phone);
                          },
                        ),
                        SizedBox(width: 8.w),
                        ContactButtonCard(
                          image: AssetsManager.location,
                          onTap: () {
                            ContactLauncherService.openMapByLink(
                              place.mapLink ?? "",
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Bottom Sheet (تعديل / حذف)
  void _showPlaceMenu(BuildContext context, DalelAlShamPlaceEntity place) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text("تعديل"),
                onTap: () {
                  Navigator.pop(context);
                  _openEditPlaceBottomSheet(context, place);

                },
              ),

              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text("حذف"),
                onTap: () {
                  Navigator.pop(context);
                  context.read<DeletePlaceViewModel>().deletePlace(place.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openEditPlaceBottomSheet(BuildContext context, DalelAlShamPlaceEntity place) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<UpdatePlaceViewModel>()),
            BlocProvider(create: (context) => getIt<AddPlaceViewModel>()),
            BlocProvider(create: (context) => getIt<DeletePlaceViewModel>()),
          ],


          child: PlaceFormSheet(
            parentContext: context,
            place: DalelAlShamPlaceModel(
              id: place.id,
              name: place.name,
              description: place.description,
              addressText: place.addressText,
              phone: place.phone,
              mapLink: place.mapLink,
              images: place.images,
            ),
          ),
        );
      },
    );
  }



}
