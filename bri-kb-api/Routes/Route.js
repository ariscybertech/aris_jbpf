'use strict';

module.exports = function(app) {
    
   var propinsiController = require('../Controllers/PropinsiController');
   app.route('/propinsi').get(propinsiController.getData);
   app.route('/propinsi/:id').get(propinsiController.getDataById);

   var kontrasepsiController = require('../Controllers/KontrasepsiController');
   app.route('/kontrasepsi').get(kontrasepsiController.getData);
   app.route('/kontrasepsi/:id').get(kontrasepsiController.getDataById);

   var transactionController = require('../Controllers/TransactionController');
   app.route('/transaction').get(transactionController.getData);
   app.route('/transaction/report/').get(transactionController.getDataReport);
   app.route('/transaction/').post(transactionController.insert);
};