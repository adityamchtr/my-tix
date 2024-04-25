
//Icons
import 'package:mytix/app/modules/main/event/event_model.dart';

const icMainHome = "assets/icons/main_home.svg";
const icMainHomeSelected = "assets/icons/main_home_selected.svg";
const icMainSearch = "assets/icons/main_search.svg";
const icMainSearchSelected = "assets/icons/main_search_selected.svg";
const icMainWishlist = "assets/icons/main_wishlist.svg";
const icMainWishlistSelected = "assets/icons/main_wishlist_selected.svg";
const icMainTicket = "assets/icons/main_ticket.svg";
const icMainTicketSelected = "assets/icons/main_ticket_selected.svg";
const icMainProfile = "assets/icons/main_profile.svg";
const icMainProfileSelected = "assets/icons/main_profile_selected.svg";
const icGoogle = "assets/icons/google.svg";
const icNotification = "assets/icons/notification.svg";
const icSearch = "assets/icons/search.svg";
const icSearchAppbar = "assets/icons/search_appbar.svg";
const icLocation = "assets/icons/location.svg";
const icProfileAbout = "assets/icons/profile_about.svg";
const icProfileAccount = "assets/icons/profile_account.svg";
const icProfileContact = "assets/icons/profile_contact.svg";
const icProfileInfo = "assets/icons/profile_info.svg";
const icProfileLogout = "assets/icons/profile_logout.svg";
const icProfilePassword = "assets/icons/profile_password.svg";
const icProfileTicket = "assets/icons/profile_ticket.svg";
const icProfileTransaction = "assets/icons/profile_transaction.svg";
const icShare= "assets/icons/share.svg";
const icLike = "assets/icons/like.svg";
const icLiked = "assets/icons/liked.svg";
const icEventLocation = "assets/icons/event_location.svg";
const icEventDate = "assets/icons/event_date.svg";
const icTicket = "assets/icons/ticket.svg";
const icVoucher = "assets/icons/voucher.svg";
const icRadioOff = "assets/icons/radio_off.svg";
const icRadioOn = "assets/icons/radio_on.svg";
const icInfo = "assets/icons/info.svg";

//Images
const imBoarding1 = "assets/images/boarding1.png";
const imBoarding2 = "assets/images/boarding2.png";
const imBoarding3 = "assets/images/boarding3.png";
const imLogo = "assets/images/logo.png";
const imSuccess = "assets/images/success.svg";
const imAvatar = "assets/images/avatar.svg";
const imBanner = "assets/images/banner.png";
const imBannerEvent = "assets/images/banner_event.png";
const imBannerTicket = "assets/images/banner_ticket.png";
const ilNotification = "assets/images/il_notification.svg";
const ilReview = "assets/images/il_review.svg";
const ilEmpty = "assets/images/il_empty.svg";
const ilSearch = "assets/images/il_search.svg";
const imEventMaker = "assets/images/event_maker.png";
const imEventMap = "assets/images/event_map.png";
const imPaymentBni = "assets/images/payment_bni.png";
const imPaymentDana = "assets/images/payment_dana.png";
const imPaymentGopay = "assets/images/payment_gopay.png";
const imPaymentIndomaret = "assets/images/payment_indomaret.png";
const imPaymentLinkaja = "assets/images/payment_linkaja.png";
const imPaymentMandiri = "assets/images/payment_mandiri.png";
const imPaymentOvo = "assets/images/payment_ovo.png";
const imPaymentQris = "assets/images/payment_qris.png";
const imPaymentShopeepay = "assets/images/payment_shopeepay.png";

//Lottie
const loComplete = "assets/lottie/complete.json";

const ticketDummies = {
  "data": [
    {
      "id": "early",
      "title": "Early Bird Tiket",
      "ticketChild": [
        {
          "id": "1",
          "name": "Early Bird - Day 1",
          "date": "Minggu, 28 Januari 2024",
          "status": true,
          "price": 45000.0,
        },
        {
          "id": "2",
          "name": "Early Bird - Day 2",
          "date": "Minggu, 29 Januari 2024",
          "status": true,
          "price": 45000.0,
        }
      ],
    },
    {
      "id": "regular",
      "title": "Regular",
      "ticketChild": [
        {
          "id": "3",
          "name": "Regular - Day 1",
          "date": "Minggu, 28 Januari 2024",
          "status": false,
          "price": 45000.0,
        },
        {
          "id": "4",
          "name": "Regular - Day 2",
          "date": "Minggu, 29 Januari 2024",
          "status": true,
          "price": 45000.0,
        }
      ],
    },
    {
      "id": "presale",
      "title": "Presale",
      "ticketChild": [],
    }
  ]
};

const paymentMethodDummies = {
  "data": [
    {
      "id": "va",
      "title": "Virtual Account",
      "paymentChild": [
        {
          "id": "1",
          "headerId": "va",
          "headerTitle": "Virtual Account",
          "name": "Bank BNI",
          "logo": imPaymentBni,
        },
        {
          "id": "2",
          "headerId": "va",
          "headerTitle": "Virtual Account",
          "name": "Bank Mandiri",
          "logo": imPaymentMandiri,
        },
      ],
    },
    {
      "id": "cashless",
      "title": "Uang elektronik",
      "paymentChild": [
        {
          "id": "3",
          "headerId": "cashless",
          "headerTitle": "Uang elektronik",
          "name": "Gopay",
          "logo": imPaymentGopay,
        },
        {
          "id": "4",
          "headerId": "cashless",
          "headerTitle": "Uang elektronik",
          "name": "OVO",
          "logo": imPaymentOvo,
        },
        {
          "id": "5",
          "headerId": "cashless",
          "headerTitle": "Uang elektronik",
          "name": "LinkAja",
          "logo": imPaymentLinkaja,
        },
        {
          "id": "6",
          "headerId": "cashless",
          "headerTitle": "Uang elektronik",
          "name": "ShoopePay",
          "logo": imPaymentShopeepay,
        },
        {
          "id": "7",
          "headerId": "cashless",
          "headerTitle": "Uang elektronik",
          "name": "Dana",
          "logo": imPaymentDana,
        },
      ],
    },
    {
      "id": "cash",
      "title": "Bayar Di Gerai",
      "paymentChild": [
        {
          "id": "8",
          "headerId": "cash",
          "headerTitle": "Bayar Di Gerai",
          "name": "Indomaret",
          "logo": imPaymentIndomaret,
        },
      ],
    },
    {
      "id": "scan",
      "title": "Scan QRIS",
      "paymentChild": [
        {
          "id": "9",
          "headerId": "scan",
          "headerTitle": "Scan QRIS",
          "name": "QRIS",
          "logo": imPaymentQris,
        },
      ],
    },
  ]
};

const paymentProvision = [
  "Pembayaran hanya dapat dilakukan oleh nasabah Bank Mandiri melalui ATM, MBanking dll.",
  "Mohon selesaikan pembayaran sebelum batas waktu berakhir untuk menghindari gagal bayar.",
  "Setelah proses berhasil, pesanan kamu akan diproses.",
];

const voucherProvision = [
  "Kode voucher dapat digunakan hanya 1x per akun, dan tidak dapat digunakan kembali setelah digunakan.",
  "Kode voucher terbatas bagi 100 orang pertama, jika kode voucher tidak dapat digunakan, maka voucher telah habis.",
  "Kode voucher dapat ditumpuk jika memang ada voucher lain yang tersedia.",
];

final List<EventItemModel> eventDummies = [
  EventItemModel(
    id: "1",
    title: "Karawang Anicosmic 2023",
    isLiked: true,
  ),
  EventItemModel(
    id: "2",
    title: "Bandung Java 2024",
    isLiked: true,
  ),
  EventItemModel(
    id: "3",
    title: "Jakarta Festival 2024",
    isLiked: true,
  ),
];

final List<EventItemModel> eventEndedDummies = [
  EventItemModel(
    id: "4",
    title: "Karawang Anicosmic 2023",
    isEnded: true,
  ),
  EventItemModel(
    id: "5",
    title: "Bandung Java 2024",
    isEnded: true,
  ),
  EventItemModel(
    id: "6",
    title: "Jakarta Festival 2024",
    isEnded: true,
  ),
];