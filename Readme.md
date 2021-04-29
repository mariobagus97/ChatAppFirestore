# CryptoList


## Installation

Use the package manager Cocoapod to install CryptoList.

```bash
pod install
```

## Usage

Cocoapod install

## Solution
saya menggunakan pattern mvvm, dengan lib alamofire untuk networking, rxswift untuk asynchronous, dan swinject (dependency injection).

swinject saya gunakan agar project bisa loosecouple, dan untuk unit text, di kesempatan kali ini saya belum mengimplementasikan unit test dikarenakan waktu 

Apps ini sudah saya profiling instrumen, saya melihat ada beberapa task main thread yang harus di manage, task di background dan di foreground, dan ada beberapa lonjakan memory ketika hit api

## Need More Time
jika ada kesempatan waktu lebih saya akan :

+ RxUnit test : ini digunakan untuk manajemen thread ketika subscribe, sehinggal kita bisa mencegah memory leak.
+ websoket
+ Profiling instrument : saya akan manage main thread dan ada beberapa yg kan saya pindahkan dari background service ke foreground

## Reason

saya diberikan tugas ini senin malam, jadi saya asumsikan 2 hari untuk mengerjakan ini. dan minggu ini adalah end of sprint kerjaan saya di kantor, load nya lumayan besar, jadi saya tetap harus memprioritaskan tiket tiket jira saya yg harus done di jumat 30 april.


## License
Muhammad ario bagus pratomo mariobagus97@gmail.com
