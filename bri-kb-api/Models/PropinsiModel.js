'use strict';

var sql = require('../Config/db');

var PropinsiModel = function(propinsi){
    this.IDPropinsi = propinsi.IDPropinsi;
    this.NamaPropinsi = propinsi.NamaPropinsi;
};

PropinsiModel.getData = function (result) {
    sql.query('select * from "LIST_PROPINSI"', function (err, res) {             
        if(err) {
            console.log("error: ", err);
            result(err, null);
        }
        else{
            result(null, res.rows);
        
        }
    });   
};

PropinsiModel.getDataByID = function (id, result) {
    sql.query('select * from "LIST_PROPINSI" where "Id_Propinsi" = $1', [id], function (err, res) {             
        if(err) {
            console.log("error: ", err);
            result(err, null);
        }
        else{
            result(null, res.rows);
        }
    });   
};


module.exports = PropinsiModel;
