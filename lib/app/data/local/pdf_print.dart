import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';
import 'package:getx_skeleton/app/modules/cart/cart_controller.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:easy_localization/easy_localization.dart';

class Facture {
  Image? image1;
  CartController cartController = Get.put(CartController());

  Future<void> generateAndPrintArabicPdf({
    required String date,
    required String total,
    required String logo,
    required String numBon,
    required String name,
    required String phone,
    required String adresse,
    required ClientModel client,
  }) async {
    final Document pdf = Document(
      title: numBon.toString(),
    );

    loadImage(logo);
    var englishfont =
        Font.ttf(await rootBundle.load("assets/Fonts/Poppins-Bold.ttf"));
    //var arabicfont = Font.ttf(await rootBundle.load("assets/fonts/Noto.ttf"));
    // Roud Facture Page
    pdf.addPage(MultiPage(
        theme: ThemeData.withFont(
          base: englishfont,
        ),
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.all(10),
        build: (Context context) {
          return [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    child: image1,
                  ),
                ]),
            header(phone, adresse, name),
            Container(
              width: 550,
              height: 2,
              //   color: PdfColor.fromHex('#000000'),
            ),
            Container(height: 5),
            Row(
              children: [
                Container(width: 5),
                Container(
                  //   width: 250,
                  padding: const EdgeInsets.all(16),
                  //    height: 150,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Code : $numBon",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(width: 25),
                            Text(
                              'DATE : ${date}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                      Container(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Client : ${client.societe}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            productTable(cartController.cartProducts),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                "TOTAL = ${numberFromat(total)} DA",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])
          ];
        }));

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/1.pdf';
    final File file = File(path);
    var savedPdf = await pdf.save();
    await file.writeAsBytes(savedPdf);
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(), name: numBon);
  }

  Center header(
    String phone,
    String adresse,
    String name,
  ) {
    return Center(
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 7),
          Text(
            phone,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 7),
          Text(
            adresse,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 7),
          Text(
            'Bon de vente',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 7),
        ],
      ),
    );
  }

  Container productTable(List<ProductModel> products) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: TableHelper.fromTextArray(
        border: TableBorder.symmetric(
            inside: BorderSide.none,
            outside: BorderSide(width: 1, color: PdfColor.fromHex('#000000'))),
        headerStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        headerCellDecoration: BoxDecoration(
          color: PdfColor.fromHex('#ffffff'),
        ),
        headers: <dynamic>[
          // 'Réference',
          'Désignation',
          'Prix',
          'Quantité',
          'Montent',
        ],
        cellAlignment: Alignment.center,
        defaultColumnWidth: const FractionColumnWidth(3),
        columnWidths: {
          0: IntrinsicColumnWidth(flex: 3),
          1: IntrinsicColumnWidth(flex: 1),
          2: IntrinsicColumnWidth(flex: 1),
          3: IntrinsicColumnWidth(flex: 1),
        },
        cellStyle: const TextStyle(fontSize: 16),
        data: <List<dynamic>>[
          ...products
              .map((e) => <dynamic>[
                    //  e.id,
                    e.product!.designation,
                    numberFromat(e.priceController!.text),
                    e.qtyController!.text,
                    numberFromat((double.parse(e.priceController!.text) *
                            double.parse(e.qtyController!.text))
                        .toString()),
                  ])
              .toList(),
        ],
      ),
    );
  }

  Future<bool> loadImage(logo) async {
    Logger().e(logo);
    final img = await rootBundle.load('assets/images/app_icon.png');
    final imageBytes = img.buffer.asUint8List();
    image1 = Image(MemoryImage(base64Decode(logo.split(',').last)));
    return true;
  }

  String numberFromat(dynamic number) {
    return NumberFormat('#,###.##')
        .format(double.parse(number))
        .toString()
        .replaceAll(',', ' ');
  }

  // String numberFromat(dynamic number) {
  //   return NumberFormat('#,###.##')
  //           .format(double.parse(number))
  //           .toString()
  //           .replaceAll(',', ' ')
  //           .contains(".")
  //       ? NumberFormat('#,###.##')
  //           .format(double.parse(number))
  //           .toString()
  //           .replaceAll(',', ' ')
  //       : "${NumberFormat('#,###.##').format(double.parse(number)).toString().replaceAll(',', ' ')} .00";
  // }
}
