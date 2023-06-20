create database Quan_Ly_Thuc_Tap;

use  Quan_Ly_Thuc_Tap;
CREATE TABLE `khoa` (
  `makhoa` CHAR(10) NOT NULL PRIMARY KEY,
  `tenkhoa` CHAR(30) ,
  `dienthoai` CHAR(10));
  
  CREATE TABLE `giangvien` (
    `magv` INT NOT NULL PRIMARY KEY,
    `hotengv` CHAR(30),
    `luong` DECIMAL(5 , 2 ),
    `makhoa` CHAR(10), FOREIGN KEY (makhoa) references khoa(makhoa)
);
CREATE TABLE `sinhvien` (
    `masv` INT NOT NULL PRIMARY KEY,
    `hotensv` CHAR(30),
    `makhoa` CHAR(10), FOREIGN KEY (makhoa) references khoa(makhoa),
    `namsinh` INT,
    `quequan` CHAR(30),
    `madt` CHAR(10) , FOREIGN KEY (madt) references detai(madt)
);
  
  CREATE TABLE `detai` (
  `madt` CHAR(10) NOT NULL PRIMARY KEY,
  `tendt` CHAR(30),
  `kinhphi` INT,
  `NoiThucTap` CHAR(30));
  
  CREATE TABLE `huongdan` (
    `masv` INT,
    FOREIGN KEY (masv)
        REFERENCES sinhvien (masv),
    `madt` CHAR(10),
    FOREIGN KEY (madt)
        REFERENCES detai (madt),
    `magv` INT,
    FOREIGN KEY (magv)
        REFERENCES giangvien (magv),
    `ketqua` DECIMAL(5 , 2 ) PRIMARY KEY
);

-- 1.Sử dụng lệnh truy vấn SQL lấy ra mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập 
select dt.madt, dt.tendt from sinhvien sv join detai dt on dt.madt = sv.madt  group by(dt.tendt) having count(sv.masv) > 2;

-- 2.Sử dụng câu lệnh truy vấn SQL lấy ra mã số, tên đề tài của đề tài có kinh phí cao nhất .
select madt, tendt from detai where kinhphi = (select kinhphi from detai order by kinhphi desc limit 1);

-- 3.Sử dụng câu lệnh SQL xuất ra Tên khoa, Số lượng sinh viên của mỗi khoa .
select k.tenkhoa, count(sv.masv) as so_luong_sv from sinhvien sv join khoa k on k.makhoa = sv.makhoa group by k.tenkhoa;

