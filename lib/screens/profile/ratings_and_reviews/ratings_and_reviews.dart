import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingsAndReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header section with profile and name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://s3-alpha-sig.figma.com/img/032d/8a85/d141711c096f32eab25e8a03399d7919?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=XYTjGI4V23~vvK3NaLrxiz272fyd0XLmpFEBhaUMSbFjaLFOxs-2vAOTp2K~~OaGhtU9dm52GoMyArj0IRuuvUTDsDa3eY5SpjcStzzk1KoG~iHiJPgpGZ2xyap1sTniW6mBpMTYNj~~4rvLzgT-vB66JMIDjsMwJSvKk2ZGOosETheblBLPRukdmQX2sEoxsykUTFE9oL6iThDHu00Di9YCD24G6847PO9aanWNCKxw6zcIchzjqBYlFoBwTP16BwLF27thPVp30FoAZo5Wc9tkeovFFvC-Abe1AR2VAotebVlKJ9PY6XZjOXo1bJSi2YweLDnpja03Ts9FxefJsQ__'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ajit Sharma',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ratings And Reviews',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Reviewed By section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviewed By Amit Mane',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Tue Mar 4',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Ratings section
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  _buildRatingItem('Punctuality', 5),
                  _buildRatingItem('Communication', 4),
                  _buildRatingItem('Professionalism', 3.5),
                  _buildRatingItem('Overall Experience', 4),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingItem(String title, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          itemCount: 5,
          itemSize: 20,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}
