const db = require("../models");
const config = require("../config/auth.config");

const Employee = db.employee;
const Op = db.Sequelize.Op;

var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");


exports.newEmployee = async (req, res) => {
    let body = req.body
    try {
     
  
      await Employee.create({

        employee_name: body.employee_name,
        jenis_kelamin: body.jenis_kelamin,
        tanggal_lahir:  body.tanggal_lahir,
        tempat_lahir: body.tempat_lahir,
        alamat_ktp: body.alamat_ktp,
        alamat_domisili: body.alamat_domisili,
        nomor_ktp: body.nomor_ktp,
        nomor_npwp: body.nomor_npwp,
        jenis_sim: body.jenis_sim,
        status_pernikahan: body.status_pernikahan,
        jumlah_anak: body.jumlah_anak,
        no_wa: body.no_wa,
        no_hp: body.no_hp,
        nama_bank: body.nama_bank,
        no_rekening: body.no_rekening,
        nama_rekening: body.nama_rekening,
        jabatan: body.jabatan
        
      })
      return res.status(200).send({
        message: "added new employee"
      })  
    }
    catch (error) {
      console.log(error);
      return res.send(error);
    }
  };