'use strict';

var kontrasepsiModel = require('../Models/KontrasepsiModel');

exports.getData = function(req, res) {
  kontrasepsiModel.getData(function(err, currency) {
    if (err){
      res.status(500).json({responseCode : 500, responseMessage : "Error", responseData :  err});
    }
    else{
      res.status(200).json({responseCode : 200, responseMessage : "Ok", responseData :  currency});
    }
  });
};

exports.getDataById = function(req, res) {
  kontrasepsiModel.getDataByID(req.params.id, function(err, propinsi) {
    if (err){
      res.status(500).json({responseCode : 500, responseMessage : "Error", responseData :  err});
    }
    else{
      res.status(200).json({responseCode : 200, responseMessage : "Ok", responseData :  propinsi});
    }
  });
};



