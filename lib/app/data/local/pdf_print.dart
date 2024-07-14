import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';
import 'package:getx_skeleton/app/modules/cart/cart_controller.dart';
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
    required ClientModel client,
  }) async {
    final Document pdf = Document();
    loadImage();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    child: image1,
                  ),
                  header(),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    //  child: Image.asset('assets/icons/logo.png'),
                  ),
                ]),
            Container(
              width: 550,
              height: 2,
              color: PdfColor.fromHex('#000000'),
            ),
            Container(height: 5),
            Row(
              children: [
                Container(width: 5),
                Expanded(
                  child: Container(
                    height: 140,
                    padding: const EdgeInsets.all(2),
                    //    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "FACTURE",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 0.5,
                            //  color: Colors.black,
                          ),
                          Text(
                            'DATE : ${date}',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(height: 5),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Client : ${client.societe}',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' Adresse :  ${client.adresse}',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' Mobile :  ${client.mobileId}',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ]),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
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
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Center header() {
    return Center(
      child: Column(
        children: [
          Text(
            'BeebCom',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 7),
          Text(
            'Creation des solition est les logiciels d\'exploitation',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'CAPITAL=25000000 DA - Cité 100 LSP Cité Bouskin 21 SETIF',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'Tél: 044758815 Fax:044756273 Email:dabeeb@gmail.com',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Container productTable(List<ProductModel> products) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: TableHelper.fromTextArray(
        headerStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        headerCellDecoration: BoxDecoration(color: PdfColor.fromHex('#8f8f8f')),
        headers: <dynamic>[
          'N°',
          'Réference',
          'Désignation',
          'Prix',
          'Quantité',
          'Montent',
        ],
        cellAlignment: Alignment.center,
        cellStyle: const TextStyle(fontSize: 8),
        data: <List<dynamic>>[
          ...products
              .map((e) => <dynamic>[
                    products.indexOf(e) + 1,
                    e.id,
                    e.product!.designation,
                    numberFromat(e.priceController!.text),
                    e.qtyController!.text,
                    numberFromat((double.parse(e.priceController!.text) *
                            double.parse(e.qtyController!.text))
                        .toString()),
                  ])
              .toList(),
          <dynamic>[
            Expanded(child: Container(height: 220)),
            Expanded(child: Container()),
            Expanded(child: Container()),
            Expanded(child: Container()),
            Expanded(child: Container()),
            Expanded(child: Container()),
            Expanded(child: Container()),
          ]
        ],
      ),
    );
  }

  Future<bool> loadImage() async {
    final img = await rootBundle.load('assets/images/app_icon.png');
    final imageBytes = img.buffer.asUint8List();
    image1 = Image(MemoryImage(imageBytes));
    return true;
  }

  String numberFromat(dynamic number) {
    return NumberFormat('#,###.##')
        .format(double.parse(number))
        .toString()
        .replaceAll(',', ' ');
  }
}
