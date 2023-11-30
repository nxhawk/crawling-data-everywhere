-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 30, 2023 lúc 04:09 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `my-shop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account`
--

CREATE TABLE `account` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Startday` date NOT NULL DEFAULT curdate(),
  `Available` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `account`
--

INSERT INTO `account` (`Username`, `Password`, `Startday`, `Available`) VALUES
('admin', '$argon2id$v=19$m=65536,t=3,p=4$gJmbBxrKkPisdDRYz1XCYQ$Vk7+4z9rDJJJxteIouSHkoc14S4zyR24mgBq3hBJ5jI', '2023-11-20', 0),
('haonhat', '$argon2id$v=19$m=65536,t=3,p=4$vd8SwsM2ht8FLDkQR2Yy3g$/kCWWytQZ4kWuMqsSusL8RIbSSs1Jz758i/S3xGn2cg', '2023-10-14', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `code`
--

CREATE TABLE `code` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `code`
--

INSERT INTO `code` (`id`, `code`) VALUES
(7, '1234567'),
(8, '1234567');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cthd`
--

CREATE TABLE `cthd` (
  `sohd` int(11) NOT NULL,
  `masp` char(4) NOT NULL,
  `sl` int(11) NOT NULL,
  `id_cthd` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoadon`
--

CREATE TABLE `hoadon` (
  `sohd` int(11) NOT NULL,
  `nghd` date NOT NULL,
  `makh` char(4) NOT NULL,
  `trigia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khachhang`
--

CREATE TABLE `khachhang` (
  `makh` char(4) NOT NULL,
  `hoten` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dchi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sodt` char(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ngsinh` date NOT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ngdk` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loai`
--

CREATE TABLE `loai` (
  `maloai` char(4) NOT NULL,
  `tenloai` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `loai`
--

INSERT INTO `loai` (`maloai`, `tenloai`) VALUES
('ML01', 'Apple'),
('ML02', 'Samsung'),
('ML03', 'Oppo'),
('ML04', 'Xiaomi'),
('ML05', 'Vivo');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `masp` char(4) NOT NULL,
  `anh` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tensp` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hangsx` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gia_goc` int(11) NOT NULL,
  `gia` int(11) NOT NULL,
  `sl` int(11) NOT NULL,
  `maloai` char(4) NOT NULL,
  `giamgia` int(11) NOT NULL,
  `public_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`masp`, `anh`, `tensp`, `hangsx`, `gia_goc`, `gia`, `sl`, `maloai`, `giamgia`, `public_id`) VALUES
('0127', 'http://res.cloudinary.com/haonhat/image/upload/v1701352568/jumzn53jdhzyrpv9wlqa.jpg', 'Xiaomi Redmi 13C', 'Xiaomi', 2060000, 3090000, 92, 'ML04', 6, 'jumzn53jdhzyrpv9wlqa'),
('0304', 'http://res.cloudinary.com/haonhat/image/upload/v1701352488/ppg9cvktbxit4hh49ufe.jpg', 'OPPO Find N3', 'Oppo', 18990000, 22990000, 31, 'ML03', 0, 'ppg9cvktbxit4hh49ufe'),
('0573', 'http://res.cloudinary.com/haonhat/image/upload/v1701352429/cpqphdamnpvfjwgvuomf.jpg', 'Samsung Galaxy A05', 'Samsung', 2060000, 3090000, 83, 'ML02', 0, 'cpqphdamnpvfjwgvuomf'),
('0722', 'http://res.cloudinary.com/haonhat/image/upload/v1701352553/mtkkfqydbhgrtzb21j5d.jpg', 'OPPO A77s', 'Oppo', 2290000, 6290000, 65, 'ML03', 23, 'mtkkfqydbhgrtzb21j5d'),
('0799', 'http://res.cloudinary.com/haonhat/image/upload/v1701352537/nnufsotmdodwz97espuj.jpg', 'OPPO A78', 'Oppo', 4990000, 6990000, 6, 'ML03', 0, 'nnufsotmdodwz97espuj'),
('0859', 'http://res.cloudinary.com/haonhat/image/upload/v1701352620/rszjpa14oxl5yjkmtwdn.jpg', 'vivo Y36', 'Vivo', 5290000, 6290000, 55, 'ML05', 7, 'rszjpa14oxl5yjkmtwdn'),
('1124', 'http://res.cloudinary.com/haonhat/image/upload/v1701352458/bgdetpvazy1q3rh4tese.jpg', 'Samsung Galaxy M54', 'Samsung', 9990000, 11990000, 22, 'ML02', 12, 'bgdetpvazy1q3rh4tese'),
('1240', 'http://res.cloudinary.com/haonhat/image/upload/v1701352450/bwy2jum41fty366arst4.jpg', 'Samsung Galaxy S22 Ultra', 'Samsung', 26990000, 30990000, 24, 'ML02', 45, 'bwy2jum41fty366arst4'),
('1327', 'http://res.cloudinary.com/haonhat/image/upload/v1700448696/ymohhj2pqqymb5wjqj1m.jpg', 'iPhone 14 Pro Max', 'Apple', 26990000, 29990000, 100, 'ML01', 8, 'ymohhj2pqqymb5wjqj1m'),
('1340', 'http://res.cloudinary.com/haonhat/image/upload/v1701352528/n4qngwr67zdlewgu7g1i.jpg', 'OPPO Reno7', 'Oppo', 4990000, 7990000, 87, 'ML03', 0, 'n4qngwr67zdlewgu7g1i'),
('1612', 'http://res.cloudinary.com/haonhat/image/upload/v1701352630/pwexlyabjohvnnwqrxvo.jpg', 'vivo Y02s', 'Vivo', 2193334, 3290000, 100, 'ML05', 9, 'pwexlyabjohvnnwqrxvo'),
('1667', 'http://res.cloudinary.com/haonhat/image/upload/v1701352623/jyvtka4i0ls1cc1xtwjd.jpg', 'vivo Y35', 'Vivo', 3990000, 6990000, 78, 'ML05', 34, 'jyvtka4i0ls1cc1xtwjd'),
('1827', 'http://res.cloudinary.com/haonhat/image/upload/v1701352618/k2qs5k73fdksod9xkneu.jpg', 'vivo V27e', 'Vivo', 6990000, 8990000, 97, 'ML05', 7, 'k2qs5k73fdksod9xkneu'),
('2019', 'http://res.cloudinary.com/haonhat/image/upload/v1701352463/dwalmukw59vzwwzoh0tb.jpg', 'Samsung Galaxy A54', 'Samsung', 7490000, 10490000, 31, 'ML02', 9, 'dwalmukw59vzwwzoh0tb'),
('2109', 'http://res.cloudinary.com/haonhat/image/upload/v1701352447/gdqonypanwswlcndethe.jpg', 'Samsung Galaxy S23+', 'Samsung', 25990000, 26990000, 90, 'ML02', 25, 'gdqonypanwswlcndethe'),
('2145', 'http://res.cloudinary.com/haonhat/image/upload/v1701352497/htfksc11pshsjub7j4nk.jpg', 'OPPO Reno10', 'Oppo', 7990000, 9990000, 34, 'ML03', 3, 'htfksc11pshsjub7j4nk'),
('2769', 'http://res.cloudinary.com/haonhat/image/upload/v1700448698/fiaekqrtxakhcm8cpvfe.jpg', 'iPhone 14 Pro', 'Apple', 26990000, 27990000, 92, 'ML01', 10, 'fiaekqrtxakhcm8cpvfe'),
('2797', 'http://res.cloudinary.com/haonhat/image/upload/v1701352452/uqgrxnhaaqtwks5tznwf.jpg', 'Samsung Galaxy S23', 'Samsung', 19990000, 22990000, 27, 'ML02', 30, 'uqgrxnhaaqtwks5tznwf'),
('2989', 'http://res.cloudinary.com/haonhat/image/upload/v1701352562/dhdr2tljw7a9rt4outy2.jpg', 'OPPO A18', 'Oppo', 2460000, 3690000, 94, 'ML03', 8, 'dhdr2tljw7a9rt4outy2'),
('3162', 'http://res.cloudinary.com/haonhat/image/upload/v1701352507/yullpd56eaphhssskluz.jpg', 'OPPO Reno8 Pro', 'Oppo', 15990000, 18990000, 80, 'ML03', 26, 'yullpd56eaphhssskluz'),
('3849', 'http://res.cloudinary.com/haonhat/image/upload/v1701352442/o0pazarp6l7kfu3mi1yi.jpg', 'Samsung Galaxy S23 Ultra', 'Samsung', 28990000, 31990000, 6, 'ML02', 28, 'o0pazarp6l7kfu3mi1yi'),
('3901', 'http://res.cloudinary.com/haonhat/image/upload/v1701352432/c7yn6yvswovjommpxsow.jpg', 'Samsung Galaxy S23 FE', 'Samsung', 12890000, 14890000, 81, 'ML02', 10, 'c7yn6yvswovjommpxsow'),
('4207', 'http://res.cloudinary.com/haonhat/image/upload/v1701352627/k8liv8vkzlhqkaxwih01.jpg', 'vivo Y16', 'Vivo', 2660000, 3990000, 76, 'ML05', 22, 'k8liv8vkzlhqkaxwih01'),
('4211', 'http://res.cloudinary.com/haonhat/image/upload/v1701352634/vxixd4qqwoqe5cwcsv6r.jpg', 'vivo Y02T', 'Vivo', 1993334, 2990000, 50, 'ML05', 0, 'vxixd4qqwoqe5cwcsv6r'),
('4286', 'http://res.cloudinary.com/haonhat/image/upload/v1700448692/qc1n598osa1guorirzp1.jpg', 'iPhone 15 Plus', 'Apple', 24990000, 25990000, 68, 'ML01', 0, 'qc1n598osa1guorirzp1'),
('4297', 'http://res.cloudinary.com/haonhat/image/upload/v1701352565/ykp6ubxcl9xe1oxgzkfm.jpg', 'OPPO A17K', 'Oppo', 2193334, 3290000, 70, 'ML03', 9, 'ykp6ubxcl9xe1oxgzkfm'),
('4336', 'http://res.cloudinary.com/haonhat/image/upload/v1701352486/blst6lqzfcmcyvngjzvs.jpg', 'OPPO Find N3', 'Oppo', 40990000, 44990000, 80, 'ML03', 0, 'blst6lqzfcmcyvngjzvs'),
('4403', 'http://res.cloudinary.com/haonhat/image/upload/v1701352455/ycxhkbuumqzt2otl1ysz.jpg', 'Samsung Galaxy Z Flip4', 'Samsung', 21990000, 23990000, 95, 'ML02', 37, 'ycxhkbuumqzt2otl1ysz'),
('4513', 'http://res.cloudinary.com/haonhat/image/upload/v1701352483/r6cbuvmfofkpqayr26wb.jpg', 'Samsung Galaxy A04s', 'Samsung', 2660000, 3990000, 38, 'ML02', 20, 'r6cbuvmfofkpqayr26wb'),
('4931', 'http://res.cloudinary.com/haonhat/image/upload/v1701352590/tjurqieev8ft56z4mful.jpg', 'Xiaomi 13 Lite', 'Xiaomi', 10490000, 11490000, 80, 'ML04', 17, 'tjurqieev8ft56z4mful'),
('5047', 'http://res.cloudinary.com/haonhat/image/upload/v1701352615/cq5shcdj6kobqmi35tcp.jpg', 'vivo V29e', 'Vivo', 5990000, 8990000, 66, 'ML05', 0, 'cq5shcdj6kobqmi35tcp'),
('5355', 'http://res.cloudinary.com/haonhat/image/upload/v1701352625/m2xljxaggpaoqd9rj2cd.jpg', 'vivo Y22s', 'Vivo', 1290000, 5290000, 14, 'ML05', 30, 'm2xljxaggpaoqd9rj2cd'),
('5385', 'http://res.cloudinary.com/haonhat/image/upload/v1700448704/vnfpkwil14kyahthjqqx.jpg', 'iPhone 13', 'Apple', 14990000, 18990000, 56, 'ML01', 13, 'vnfpkwil14kyahthjqqx'),
('5405', 'http://res.cloudinary.com/haonhat/image/upload/v1701352595/hjgabwscuhbprrbfqeua.jpg', 'Xiaomi Redmi Note 12 Pro', 'Xiaomi', 5490000, 9490000, 52, 'ML04', 10, 'hjgabwscuhbprrbfqeua'),
('5677', 'http://res.cloudinary.com/haonhat/image/upload/v1701352533/fg0hlwng0icha5tdleu0.jpg', 'OPPO Reno8 T', 'Oppo', 7490000, 8490000, 13, 'ML03', 15, 'fg0hlwng0icha5tdleu0'),
('5687', 'http://res.cloudinary.com/haonhat/image/upload/v1701352613/rq1hni16ljonazhywdk3.jpg', 'vivo V25 Pro', 'Vivo', 12990000, 13990000, 85, 'ML05', 32, 'rq1hni16ljonazhywdk3'),
('5711', 'http://res.cloudinary.com/haonhat/image/upload/v1700448709/aweftatfuuszuem4hkm7.jpg', 'iPhone 11', 'Apple', 9990000, 11990000, 98, 'ML01', 9, 'aweftatfuuszuem4hkm7'),
('5789', 'http://res.cloudinary.com/haonhat/image/upload/v1700448706/e3x4fyizhv1llcs2sxwp.jpg', 'iPhone 12', 'Apple', 14990000, 17990000, 59, 'ML01', 23, 'e3x4fyizhv1llcs2sxwp'),
('5794', 'http://res.cloudinary.com/haonhat/image/upload/v1701352499/wwkksjutvyidotckyah6.jpg', 'OPPO Reno10 Pro+', 'Oppo', 18990000, 19990000, 3, 'ML03', 0, 'wwkksjutvyidotckyah6'),
('5900', 'http://res.cloudinary.com/haonhat/image/upload/v1700448694/jdnagnar7of8yc167thk.jpg', 'iPhone 15', 'Apple', 18990000, 22990000, 1, 'ML01', 4, 'jdnagnar7of8yc167thk'),
('6107', 'http://res.cloudinary.com/haonhat/image/upload/v1701352584/x7indp45gtntsr4ag7z1.jpg', 'Xiaomi Redmi Note 12 Pro', 'Xiaomi', 5190000, 7190000, 47, 'ML04', 11, 'x7indp45gtntsr4ag7z1'),
('6202', 'http://res.cloudinary.com/haonhat/image/upload/v1701352592/ttncetzlm2x5q4v5lmie.jpg', 'Xiaomi 12', 'Xiaomi', 10990000, 13990000, 29, 'ML04', 32, 'ttncetzlm2x5q4v5lmie'),
('6433', 'http://res.cloudinary.com/haonhat/image/upload/v1700448700/phtfro4zuczu4tcoy7gq.jpg', 'iPhone 14 Plus', 'Apple', 22990000, 24990000, 73, 'ML01', 12, 'phtfro4zuczu4tcoy7gq'),
('6454', 'http://res.cloudinary.com/haonhat/image/upload/v1701352480/fjdmjkngvwknts33gqwu.jpg', 'Samsung Galaxy A05s', 'Samsung', 490000, 4490000, 80, 'ML02', 4, 'fjdmjkngvwknts33gqwu'),
('6652', 'http://res.cloudinary.com/haonhat/image/upload/v1701352515/wbyt6vhqtsslm3hvadev.jpg', 'OPPO Reno8 T', 'Oppo', 9990000, 10990000, 74, 'ML03', 18, 'wbyt6vhqtsslm3hvadev'),
('6934', 'http://res.cloudinary.com/haonhat/image/upload/v1701352468/kt6gybjqigdhruseidpw.jpg', 'Samsung Galaxy M34', 'Samsung', 4990000, 7990000, 98, 'ML02', 6, 'kt6gybjqigdhruseidpw'),
('6944', 'http://res.cloudinary.com/haonhat/image/upload/v1701352609/wtks4agvenuscjm0zwbf.jpg', 'vivo V25 series', 'Vivo', 9490000, 10490000, 94, 'ML05', 33, 'wtks4agvenuscjm0zwbf'),
('7430', 'http://res.cloudinary.com/haonhat/image/upload/v1701352560/chlxewn91jepqndei7cx.jpg', 'OPPO A17', 'Oppo', 2660000, 3990000, 42, 'ML03', 12, 'chlxewn91jepqndei7cx'),
('7492', 'http://res.cloudinary.com/haonhat/image/upload/v1701352474/wuhrvksd6fzga6nwurmz.jpg', 'Samsung Galaxy A14', 'Samsung', 4190000, 5190000, 100, 'ML02', 13, 'wuhrvksd6fzga6nwurmz'),
('7586', 'http://res.cloudinary.com/haonhat/image/upload/v1701352576/e6i9k6a062xjgqpckxml.jpg', 'Xiaomi 13T Pro', 'Xiaomi', 13990000, 15990000, 47, 'ML04', 9, 'e6i9k6a062xjgqpckxml'),
('7753', 'http://res.cloudinary.com/haonhat/image/upload/v1701352636/uc8cv37cjubpyhfkttso.jpg', 'vivo Y01', 'Vivo', 1593334, 2390000, 63, 'ML05', 12, 'uc8cv37cjubpyhfkttso'),
('8026', 'http://res.cloudinary.com/haonhat/image/upload/v1701352460/bsvwverlkitntkanpod2.jpg', 'Samsung Galaxy S21 FE', 'Samsung', 8990000, 12990000, 52, 'ML02', 23, 'bsvwverlkitntkanpod2'),
('8091', 'http://res.cloudinary.com/haonhat/image/upload/v1701352472/vi3oqxogmfg5kr7zefsi.jpg', 'Samsung Galaxy A24', 'Samsung', 4490000, 6490000, 56, 'ML02', 12, 'vi3oqxogmfg5kr7zefsi'),
('8114', 'http://res.cloudinary.com/haonhat/image/upload/v1701352573/jtnzhutqvtyjtpkml1gz.jpg', 'Xiaomi 13T', 'Xiaomi', 10990000, 11990000, 39, 'ML04', 8, 'jtnzhutqvtyjtpkml1gz'),
('8207', 'http://res.cloudinary.com/haonhat/image/upload/v1701352445/olaph3zvppoj8c89u83j.jpg', 'Samsung Galaxy Z Flip5', 'Samsung', 24990000, 25990000, 77, 'ML02', 15, 'olaph3zvppoj8c89u83j'),
('8223', 'http://res.cloudinary.com/haonhat/image/upload/v1701352601/rd9t9eup7or40obtmfkg.jpg', 'Xiaomi Redmi Note 12S', 'Xiaomi', 5690000, 6690000, 86, 'ML04', 17, 'rd9t9eup7or40obtmfkg'),
('8232', 'http://res.cloudinary.com/haonhat/image/upload/v1701352555/cofs0yhsapptta0zeoau.jpg', 'OPPO A38', 'Oppo', 3490000, 4490000, 53, 'ML03', 6, 'cofs0yhsapptta0zeoau'),
('8364', 'http://res.cloudinary.com/haonhat/image/upload/v1701352611/yckxz8u3syk0qnjpbzhj.jpg', 'vivo V29', 'Vivo', 9990000, 12990000, 35, 'ML05', 0, 'yckxz8u3syk0qnjpbzhj'),
('8375', 'http://res.cloudinary.com/haonhat/image/upload/v1700448685/kumz965lge7a5dub3tht.jpg', 'iPhone 15 Pro', 'Apple', 26990000, 28990000, 40, 'ML01', 0, 'kumz965lge7a5dub3tht'),
('8450', 'http://res.cloudinary.com/haonhat/image/upload/v1701352606/fqypxw3aohuplked8hsw.jpg', 'vivo Y17s', 'Vivo', 3490000, 4490000, 87, 'ML05', 4, 'fqypxw3aohuplked8hsw'),
('8687', 'http://res.cloudinary.com/haonhat/image/upload/v1701352434/aq5fzlrkauwgczwsitfw.jpg', 'Samsung Galaxy Z Fold5', 'Samsung', 36990000, 40990000, 18, 'ML02', 9, 'aq5fzlrkauwgczwsitfw'),
('8843', 'http://res.cloudinary.com/haonhat/image/upload/v1701352477/s2q1unrb6hdcptt1jdar.jpg', 'Samsung Galaxy A14', 'Samsung', 1990000, 4990000, 46, 'ML02', 12, 's2q1unrb6hdcptt1jdar'),
('8920', 'http://res.cloudinary.com/haonhat/image/upload/v1701352502/cjswieaoix04wjtu45ft.jpg', 'OPPO Reno10 Pro', 'Oppo', 12990000, 13990000, 91, 'ML03', 0, 'cjswieaoix04wjtu45ft'),
('8996', 'http://res.cloudinary.com/haonhat/image/upload/v1701352465/kpo1xo9av6khpezphxc5.jpg', 'Samsung Galaxy A34', 'Samsung', 5490000, 8490000, 79, 'ML02', 11, 'kpo1xo9av6khpezphxc5'),
('9022', 'http://res.cloudinary.com/haonhat/image/upload/v1701352439/t7zsza4aqyhj4bevrwyi.jpg', 'Samsung Galaxy Z Fold4', 'Samsung', 36990000, 40990000, 44, 'ML02', 36, 't7zsza4aqyhj4bevrwyi'),
('9097', 'http://res.cloudinary.com/haonhat/image/upload/v1701352604/ukfygr2t8vtmqyhrfqln.jpg', 'Xiaomi Redmi A2 series', 'Xiaomi', 1460000, 2190000, 11, 'ML04', 13, 'ukfygr2t8vtmqyhrfqln'),
('9201', 'http://res.cloudinary.com/haonhat/image/upload/v1701352581/lr00mvltzn0dnqaowfjj.jpg', 'Xiaomi Redmi Note 12', 'Xiaomi', 3490000, 6490000, 39, 'ML04', 15, 'lr00mvltzn0dnqaowfjj'),
('9298', 'http://res.cloudinary.com/haonhat/image/upload/v1701352504/dxmxoj4bqhjapbbcikzb.jpg', 'OPPO A57', 'Oppo', 1990000, 4990000, 30, 'ML03', 24, 'dxmxoj4bqhjapbbcikzb'),
('9389', 'http://res.cloudinary.com/haonhat/image/upload/v1701352598/yamamh6perby2eudbp08.jpg', 'Xiaomi Redmi Note 12 Pro Tím', 'Xiaomi', 8490000, 9490000, 96, 'ML04', 10, 'yamamh6perby2eudbp08'),
('9473', 'http://res.cloudinary.com/haonhat/image/upload/v1701352512/wu1vto4r6fzaxfwptafe.jpg', 'OPPO Find N2 Flip', 'Oppo', 17990000, 19990000, 8, 'ML03', 0, 'wu1vto4r6fzaxfwptafe'),
('9775', 'http://res.cloudinary.com/haonhat/image/upload/v1701352549/nokjcjy1lvgjmjn2bv1p.jpg', 'OPPO A58', 'Oppo', 4990000, 5990000, 47, 'ML03', 5, 'nokjcjy1lvgjmjn2bv1p'),
('9803', 'http://res.cloudinary.com/haonhat/image/upload/v1701352587/flpawvzkqifeaqbiezbf.jpg', 'Xiaomi Redmi 12C', 'Xiaomi', 2393334, 3590000, 17, 'ML04', 30, 'flpawvzkqifeaqbiezbf'),
('9862', 'http://res.cloudinary.com/haonhat/image/upload/v1700448703/evopkfxu41rjgsnmftxw.jpg', 'iPhone 14', 'Apple', 18990000, 21990000, 80, 'ML01', 13, 'evopkfxu41rjgsnmftxw'),
('9937', 'http://res.cloudinary.com/haonhat/image/upload/v1701352520/qhxi6s0kmrc7fyyhnxtx.jpg', 'OPPO A98', 'Oppo', 6990000, 8990000, 51, 'ML03', 5, 'qhxi6s0kmrc7fyyhnxtx'),
('SP01', 'http://res.cloudinary.com/haonhat/image/upload/v1697384754/xdmjbhdmanbpowgkpfnc.jpg', 'iPhone 15 Pro Max', 'Apple', 19990000, 21990000, 50, 'ML01', 12, NULL),
('SP02', 'http://res.cloudinary.com/haonhat/image/upload/v1698062899/xaxavilkca4hwnfy8olw.jpg', 'Samsung Galaxy', 'Samsung', 30000000, 26990000, 100, 'ML02', 0, NULL),
('SP66', 'http://res.cloudinary.com/haonhat/image/upload/v1700375050/gbpjujbjhu60kh8vxmfc.jpg', 'OPPO A17', 'Oppo', 3000000, 3990000, 12, 'ML03', 12, 'gbpjujbjhu60kh8vxmfc'),
('SP69', 'http://res.cloudinary.com/haonhat/image/upload/v1700375048/uqpgiurftufq5j5czah8.jpg', 'OPPO Reno7 series', 'Oppo', 7000000, 7490000, 10, 'ML03', 0, 'uqpgiurftufq5j5czah8');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`Username`);

--
-- Chỉ mục cho bảng `code`
--
ALTER TABLE `code`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `cthd`
--
ALTER TABLE `cthd`
  ADD PRIMARY KEY (`id_cthd`);

--
-- Chỉ mục cho bảng `hoadon`
--
ALTER TABLE `hoadon`
  ADD PRIMARY KEY (`sohd`),
  ADD KEY `makh` (`makh`);

--
-- Chỉ mục cho bảng `khachhang`
--
ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`makh`);

--
-- Chỉ mục cho bảng `loai`
--
ALTER TABLE `loai`
  ADD PRIMARY KEY (`maloai`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`masp`),
  ADD KEY `maloai` (`maloai`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `code`
--
ALTER TABLE `code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `cthd`
--
ALTER TABLE `cthd`
  MODIFY `id_cthd` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
