import 'package:flutter/material.dart';

void showDescriptionDialog(
  BuildContext context,
  String title,
  String description,
  String priority,
  String date,
  Color priorityColor,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [


            //colorful dot
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: priorityColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10),


            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),

            SizedBox(height: 10),

            // Priority label
            // Row(
            //   children: [
            //     Text(
            //       "Priority: ",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 14,
            //         color: Colors.black,
            //       ),
            //     ),
            //     Text(
            //       priority,
            //       style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold,
            //         color: priorityColor,
            //       ),
            //     ),
            //   ],
            // ),

            SizedBox(height: 5),

            // Date
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.blueGrey),
                SizedBox(width: 6),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: TextStyle(color: Colors.blueGrey.shade700,fontSize: 16),
            ),
          ),
        ],
      );
    },
  );
}
