import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dlyl_alsham_dashboard/core/utils/colors_manager.dart';
import 'package:dlyl_alsham_dashboard/core/utils/assets_manager.dart';
import '../../../../../../../core/components/custom_text_field.dart';

class AdminProjectEditViewBody extends StatefulWidget {
  const AdminProjectEditViewBody({super.key});

  @override
  State<AdminProjectEditViewBody> createState() =>
      _AdminProjectEditViewBodyState();
}

class _AdminProjectEditViewBodyState extends State<AdminProjectEditViewBody> {
  final titleController = TextEditingController(text: "عنوان المشروع");
  final locationController = TextEditingController(text: "دمشق");
  final descriptionController = TextEditingController(text: "وصف المشروع ...");
  final whatsappController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final websiteController = TextEditingController();
  final fromController = TextEditingController(text: "9:00 صباحًا");
  final toController = TextEditingController(text: "9:00 مساءً");
  String tier = "normal"; // default
  final durationController = TextEditingController(text: "30"); // مدة الإعلان بالأيام

  List<String> galleryImages = [
    AssetsManager.project1,
    AssetsManager.project2,
    AssetsManager.project3,
  ];

  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ----------------- صور البانر -----------------
                  _label("صور المشروع"),
                  SizedBox(height: 10.h),

                  SizedBox(
                    height: 140.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...galleryImages.map(
                              (e) => Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.asset(
                                e,
                                width: 200.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: ColorsManager.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(Icons.add, size: 26.sp),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ----------------- عنوان المشروع -----------------
                  _label("عنوان المشروع"),
                  CustomTextFormField(
                    hintText: "",
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 20.h),

                  // ----------------- الموقع -----------------
                  _label("الموقع"),
                  CustomTextFormField(
                    hintText: "",
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 20.h),

                  // ----------------- رقم الهاتف -----------------
                  _label("رقم الهاتف + واتس اب"),
                  CustomTextFormField(
                    hintText: "",
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20.h),

                  // ----------------- الوصف -----------------
                  _label("الوصف"),
                  CustomTextFormField(
                    hintText: "",
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),

                  SizedBox(height: 20.h),

                  // ----------------- وقت العمل -----------------
                  _label("وقت العمل"),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: _labeledTextField("من الساعة", fromController),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _labeledTextField("إلى الساعة", toController),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // ----------------- روابط التواصل -----------------
                  _label("روابط التواصل"),
                  SizedBox(height: 10.h),

                  _labeledTextField("رابط فيسبوك", facebookController),
                  _labeledTextField("رابط إنستغرام", instagramController),
                  _labeledTextField("الموقع الإلكتروني", websiteController),

                  SizedBox(height: 20.h),
// ---------------- مدة الإعلان ----------------
                  _label("مدة الإعلان"),
                  _durationField(),
                  SizedBox(height: 20.h),

// ---------------- نوع الإعلان ----------------
                  _label("نوع الإعلان"),
                  _tierDropdown(),
                  SizedBox(height: 20.h),

                  // ----------------- معرض الصور -----------------
                  _label("معرض الصور"),
                  SizedBox(height: 10.h),

                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      ...galleryImages.map(
                            (img) => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.asset(
                                img,
                                width: 110.w,
                                height: 110.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 4,
                              top: 4,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.close,
                                      color: Colors.white, size: 16.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 110.w,
                          height: 110.h,
                          decoration: BoxDecoration(
                            color: ColorsManager.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(Icons.add, size: 26.sp),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: SwitchListTile(
                      activeColor: ColorsManager.primaryColor,
                      title: const Text("تفعيل عداد المشاهدات"),
                      value: isActive,
                      onChanged: (v) {
                        setState(() => isActive = v);
                      },
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(16.w),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    // TODO: تنفيذ عملية نشر الإعلان
                  },
                  child: Text(
                    "موافقة ونشر الإعلان",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    // TODO: تنفيذ عملية رفض الإعلان
                  },
                  child: Text(
                    "رفض / إلغاء الموافقة",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h,)

      ],
    );
  }

  // --------------------- Widgets Helpers ---------------------

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.primaryColor,
      ),
    );
  }

  Widget _labeledTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _tierDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: tier,
              items: const [
                DropdownMenuItem(value: "normal", child: Text("عادي")),
                DropdownMenuItem(value: "silver", child: Text("فضي")),
                DropdownMenuItem(value: "gold", child: Text("ذهبي")),
              ],
              onChanged: (val) {
                setState(() => tier = val!);
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget _durationField() {
    return _labeledTextField("مدة الإعلان (بالأيام)", durationController);
  }

}
