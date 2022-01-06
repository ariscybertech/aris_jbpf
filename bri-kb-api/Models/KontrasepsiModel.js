'use strict';

var sql = require('../Config/db');

var KontrasepsiModel = function(kontrasepsi){
    this.IDKontrasepsi = kontrasepsi.IDKontrasepsi;
    this.NamaKontrasepsi = kontrasepsi.NamaKontrasepsi;
};

KontrasepsiModel.getData = function (result) {
    sql.query('select * from "LIST_KONTRASEPSI"', function (err, res) {             
        if(err) {
            console.log("error: ", err);
            result(err, null);
        }
        else{
            result(null, res.rows);
        
        }
    });   
};

KontrasepsiModel.getDataByID = function (id, result) {
    sql.query('select * from "LIST_KONTRASEPSI" where "Id_Kontrasepsi" = $1', [id], function (err, res) {             
        if(err) {
            console.log("error: ", err);
            result(err, null);
        }
        else{
            result(null, res.rows);
        }
    });   
};


module.exports = KontrasepsiModel;
