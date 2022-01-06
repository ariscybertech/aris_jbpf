'use strict';

var sql = require('../Config/db');

var TransactionModel = function(transaction){
    this.IDList = transaction.IDList;
    this.IDPropinsi = transaction.IDPropinsi;
    this.NamaPropinsi = propinsi.NamaPropinsi;
    this.IDKontrasepsi = transaction.IDKontrasepsi;
    this.NamaKontrasepsi = transaction.NamaKontrasepsi;
    this.JumlahPemakaian = transaction.JumlahPemakaian;
};

TransactionModel.getData = function (result) {
    sql.query('select * from "LIST_PEMAKAI_KONTRASEPSI"', function (err, res) {             
        if(err) {
            console.log("error: ", err);
            result(err, null);
        }
        else{
            result(null, res.rows);
        
        }
    });   
};

TransactionModel.getDataReport = function (result) {
    sql.query('select * from "funcGetDataReport"()', function (err, res) {             
        if(err) {
            console.log("error: ", err);
            result(err, null);
        }
        else{
            result(null, res.rows);
        
        }
    });   
};

TransactionModel.insert = function (req, result) {
    var data = [
        req.idPropinsi,
        req.idKontrasepsi,
        req.jumlah
    ];
    var sqlExec = 'CALL "proctransactionsave"($1, $2 ,$3)';
    sql.query(sqlExec, data, function (err, res) {             
        if(err) {
            console.log("error: ", err);
            result(err, null);
        }
        else{
            result(null, res.rows);
        }
    });   
};


module.exports = TransactionModel;
