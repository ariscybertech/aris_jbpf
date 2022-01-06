'use strict';

var propinsiModel = require('../Models/PropinsiModel');

exports.getData = function(req, res) {
  propinsiModel.getData(function(err, propinsi) {
    if (err){
      res.status(500).json({responseCode : 500, responseMessage : "Error", responseData :  err});
    }
    else{
      res.status(200).json({responseCode : 200, responseMessage : "Ok", responseData :  propinsi});
    }
  });
};

exports.getDataById = function(req, res) {
  propinsiModel.getDataByID(req.params.id, function(err, propinsi) {
    if (err){
      res.status(500).json({responseCode : 500, responseMessage : "Error", responseData :  err});
    }
    else{
      res.status(200).json({responseCode : 200, responseMessage : "Ok", responseData :  propinsi});
    }
  });
};



