'use strict';

var transactionModel = require('../Models/TransactionModel');

exports.getData = function(req, res) {
  transactionModel.getData(function(err, transaction) {
    if (err){
      res.status(500).json({responseCode : 500, responseMessage : "Error", responseData :  err});
    }
    else{
      res.status(200).json({responseCode : 200, responseMessage : "Ok", responseData :  transaction});
    }
  });
};

exports.getDataReport = function(req, res) {
  transactionModel.getDataReport(function(err, transaction) {
    if (err){
      res.status(500).json({responseCode : 500, responseMessage : "Error", responseData :  err});
    }
    else{
      res.status(200).json({responseCode : 200, responseMessage : "Ok", responseData :  transaction});
    }
  });
};

exports.insert = function(req, res) {
  var body = req.body;

  //handles null error 
  if(!body.idPropinsi || !body.idKontrasepsi || !body.jumlah){
      res.status(400).send({ error:true, message: 'Error data post' });
  }
  else{
    transactionModel.insert(body, function(err, transaction) {
      if (err){
        res.status(500).json({responseCode : 500, responseMessage : "Error", responseData :  err});
      }
      else{
        res.status(200).json({responseCode : 200, responseMessage : "Success", responseData :  transaction});
      }
    });
  }
};
