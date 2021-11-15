const util = require("util");
const multer = require("multer");
const maxSize = 2 * 1024 * 1024;
const path = require("path")

let storage = multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, __basedir + "/resources/static");
    },
    filename: (req, file, cb) => {
      //console.log(req.body.waybillnum)
      
      cb(null, req.body.waybillnum + ".png");
      //cb(null, req.body.waybillnum + ".png");
    },
  });

// let storages = multer.memoryStorage()

let uploadFile = multer({
  storage: storage,
}).single("files");

let uploadFileMiddleware = util.promisify(uploadFile);
module.exports = uploadFileMiddleware;