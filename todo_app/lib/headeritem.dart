import 'package:flutter/material.dart';
class HeaderItem extends StatelessWidget {
  const HeaderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width, // mediaquery property 'si elimizdeki telefona göre şekillendirme
                  height: MediaQuery.of(context).size.height /3, // ekranın 3'te biri kadar
                  decoration: const BoxDecoration(// bu Container'in içine png eklememizi sağladı
                      image: DecorationImage(
                          image: AssetImage("lib/assest/images/header.png"), // nereden alalım
                          fit: BoxFit.cover // png'yi Container'in boyutu kadar ayarla
                          )
                        ),
                  child: const Column(
                    // column dedik çünkü alt alta başlıklar yazıcaz
                    children: [
                      Padding(// padding ekledik tarih Text'i için yukarda 20 birim boşluk olsun
                          padding:EdgeInsets.only(top: 20), // 20 birim boşluk bırak
                          child: Text("April 10, 2020",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))),
                      Padding(
                          padding: EdgeInsets.only(
                              top: 40), // bu da yukarıyla 40 birim boşluk olsun
                          child: Text("TODO APP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold)))
                    ],
            )
        );
    }
}