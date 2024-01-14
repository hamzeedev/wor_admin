import 'package:get/get.dart';
import 'package:wor_admin/views/widgets/text_style.dart';
import '../../const/const.dart';

class WheelDetails extends StatelessWidget {
  final dynamic data;
  const WheelDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: darkGrey,
          ),
        ),
        title: boldText(text: "${data['w_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 250,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,

                //by given line is fatching images length from database
                itemCount: data['w_imgs'].length,
                itemBuilder: (context, index) {
                  return Image.network(
                    data['w_imgs'][index],
                    //by given line is fatching images length from database
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            10.heightBox,
            //name, category and sub category section....
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title and details...

                  boldText(text: "${data['w_name']}", color: fontGrey, size: 18.0),
                  //rating
                  10.heightBox,
                  Row(children: [
                    boldText(text: "${data['w_category']}", color: fontGrey, size: 16.0),
                    10.widthBox,
                    normalText(text: "${data['w_subcategory']}", color: fontGrey, size: 16.0),
                  ],),
                  const Divider(),
                  //rating and price section
                  VxRating(
                    //by given line we have fixed the rating
                    isSelectable: false,
                    //by given line rating is fetched from database
                    value: double.parse(data['w_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  boldText(text: "${data['w_price']} RS", color: red, size: 18.0),
                  10.heightBox,
                  //color Section...
                  20.heightBox,
                //to show colors  
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color:", color: fontGrey),
                          ),
                          Row(
                            children: List.generate(
                              data['w_colors'].length,
                              (index) => VxBox()
                                  .size(30, 30)
                                  .roundedFull
                                  .margin(const EdgeInsets.symmetric(horizontal: 3))
                                  .color(Color(data['w_colors'][index]))
                                  .make()
                                  .onTap(() {}),
                            ),
                          )
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),

                      //quantity row (ADD DAYS)...
                      //to show days...
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Days:", color: fontGrey),
                          ),
                          normalText(text: "${data['w_days']} Day", color: fontGrey)
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),

                      //total wali row...
                    ],
                  ).box.padding(const EdgeInsets.all(8)).make(),
                  const Divider(),
                  10.heightBox,
                  boldText(text: "Description:", color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['w_desc']} Day", color: fontGrey)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
