let express = require('express');
let app = express();
const debug = require('debug');
let cookieParser = require('cookie-parser');
let admin = require('./public/javascripts/admin');


// let indexRouter = require('./routes/index');
let usersRouter = require('./routes/users');
let testRouter = require('./routes/test')

/* ----- СТАТИКА ----- */
app.use(express.static('public'));
// app.use('/', indexRouter)
// app.use('/users', usersRouter)
// app.use('/test', testRouter)

/* ----- ШАБЛОНИЗАТОР ----- */

app.set('view engine', 'pug')

let mysql = require('mysql');
const nodemailer = require('nodemailer');

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cookieParser());

let con = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'root2',
    database: process.env.DB_DATABASE || 'shop',
    port: process.env.DB_PORT || 3306
})

process.env["NODE_TLC_REJECT_UNAUTHORIZED"] = 0;

app.listen(3000, function() {
    // console.log("node on port 3000");
});

app.use(function(req, res, next){
  console.log('time', Date.now());
  if (req.originalUrl === '/admin' || req.originalUrl === '/admin-order') {
    admin(req, res, con, next)
  } else {
    next();
  }
  // next();
})

app.get('/', function(req, res) {
   let cat = new Promise(function(resolve, reject){
    con.query('select id, name, cost, image, category from (select id, name, cost, image, category, if(if(@curr_category != category, @curr_category := category, "") != "", @k := 0, @k := @k + 1) as ind from goods, (select @curr_category := "") v ) goods where ind < 3',
    function(error, result, field){
      if (error) return reject(error);
      resolve(result)
      console.log("index1", result)
    })
   })
   let catDescription = new Promise(function(resolve, reject){
    con.query('select * from categories', 
    function(error, result, field){
      if (error) return reject(error);
      resolve(result);
      console.log("index2", result)
    })
   })
   Promise.all([cat, catDescription]).then(function(value){
    res.render('index', {
      goods: JSON.parse(JSON.stringify(value[0])),
      category: JSON.parse(JSON.stringify(value[1]))
    })
   })
})

app.get('/allcat', function(req, res) {
  // console.log("req", req);
  // let catID = req.query.id;
    con.query(
      'SELECT * FROM categories',
      function(error, result){
        if(error) throw error
        
        let categories = {};
        for (let i = 0; i < result.length; i++) {
            categories[result[i]['id']] = result[i];
        }
        console.log(categories);
        

        res.render('allcat', {
          
          categories: JSON.parse(JSON.stringify(categories))
      })
      }
      )
    })

app.get('/cat', function(req, res) {
    console.log("req", req);
    let catID = req.query.id;
    let categories = new Promise(function(resolve, reject){
      con.query(
        'SELECT * FROM categories',
        function(error, result){
          if(error) throw error
          resolve(result)
        }
        )
    })
    let goods = new Promise(function(resolve, reject){
      con.query(
        'SELECT * FROM goods WHERE category='+catID,
        function(error, result){
          if(error) throw error
          resolve(result)
        }
        )
    })
  
    Promise.all([categories, goods]).then(function(value){
      console.log("value0", value[0]);
      console.log("value1", value[1]);
      res.render('cat',{
        categories :  JSON.parse(JSON.stringify(value[0])),
        goods :  JSON.parse(JSON.stringify(value[1]))
      })
    })
    
  })

  app.get('/goods', function (req, res) {
    console.log(req.query.id);
    con.query('SELECT * FROM goods WHERE id=' + req.query.id, function (error, result, fields) {
      if (error) throw error;
      let goods = {};
      for (i = 0; i < result.length; i++) {
        goods[result[i]['id']] = result[i]
      }
      goods = JSON.parse(JSON.stringify(goods))
      console.log(JSON.parse(JSON.stringify(result)));
      res.render('goods', { goods: JSON.parse(JSON.stringify(result)) });
    });
  });

  app.get('/order', function(req, res){
    res.render('order')
  })

  app.post('/get-category-list', function(req, res) {
    console.log(req.body);
    con.query('SELECT  id, category FROM categories', function(error, result, fields) {
      if (error) throw error;
      console.log('get-category-list', result)
      res.json(result)
    })
  })

  app.post('/get-goods-info', function(req, res) {
    if (req.body.key.length > 0) {
      con.query('SELECT  id, name, cost FROM goods WHERE id IN ('+req.body.key.join(',')+')', function(error, result, fields) {
        if (error) throw error;
        let goods = {};
        for (let i = 0; i < result.length; i++) {
          goods[result[i]['id']] = result[i]
        }
        console.log('get-goods-info', goods)
        goods = JSON.parse(JSON.stringify(goods))
        // console.log(JSON.parse(JSON.stringify(result)));
        res.json(goods)
      })
    } else {
      res.send("0");
      console.log("000")
    }
  })

  app.post('/finish-order', function(req, res){
    console.log('finish', req.body);
    res.send('1');
    if (req.body.key.length === '') {
      res.send('0')
    } else {
      let keys = Object.keys(req.body.key);
      con.query(
        'select id, name, cost from goods where id in (' + keys.join(',') + ')', 
        function(error, result, field) {
          if (error) throw error;
          result = JSON.parse(JSON.stringify(result));
          console.log("result finish", result);
          sendingMail(req.body, result).catch(console.error);
          saveOrder(req.body, result);
          // res.send('1')
        }
      )
    }
  })

  app.get('/login', function(req, res){
    res.render('login', {})
  })

  app.get('/admin', function(req, res){
    res.render('admin', {})
  })

  app.post('/login', function(req, res){
    // res.end('work')
    console.log("reqbody", req.body)
    con.query(
      'SELECT * FROM user WHERE login="' + req.body.login + '" and password="' + req.body.password + '"',
      function(error, result) {
        if (error) reject (error);
        if (result.length === 0) {
          console.log("USER NOT FOUND")
          res.redirect('/login');
        } else {
          console.log("USER FOUND", result);
          result = JSON.parse(JSON.stringify(result));
          let hash = makeHash(32);
          res.cookie('hash', hash)
          res.cookie('id', result[0]['id'])
          sql = "UPDATE user SET hash='" + hash + "' WHERE id=" + result[0]['id']
          con.query(sql, function(error, resultQuery){
            if(error) throw error;
            res.redirect('/admin')
          })
        }
      }
    )
  })

  app.get('/admin-order', function(req, res){
    con.query(`SELECT 
    shop_order.id as id,
      shop_order.user_id as user_id,
      shop_order.goods_id as goods_id,
      shop_order.goods_cost as goods_cost,
      shop_order.goods_amount as goods_amount,
      shop_order.total as total,
      from_unixtime(date, '%Y-%m-%d %h:%m') as human_date,
      user_info.user_name as user_name,
      user_info.user_phone as user_phone,
      user_info.address as address
  FROM 
    shop_order
  LEFT JOIN
    user_info
  ON shop_order.user_id = user_info.id;`, function(error, result){
      if (error) throw error;
      res.render('admin-order',{ order: JSON.parse(JSON.stringify(result))})
    })
  })

  function saveOrder(data, result) {
    // data - информация о пользователе
    // result - информация от товаре
    let sql;
    sql = "INSERT INTO `user_info` (user_name, user_phone, user_email, address) VALUES ('" + data.username + "','" + data.phone + "','" + data.email + "','" + data.address + "')";
    con.query(sql, function(error, resultQuery){
      if (error) throw error;
      console.log("sql", sql);
      console.log("1 user info saved");
      console.log("result", resultQuery)
      let userID = resultQuery.insertId;
      let date = new Date()/1000
      console.log(result)
      for (let i = 0; i < result.length; i++){
        sql = "INSERT INTO `shop_order` (date, user_id, goods_id, goods_cost, goods_amount, total) VALUES (" + date + "," + userID + "," + result[i]['id'] + "," + result[i]['cost'] + "," + data.key[result[i]['id']] + "," + data.key[result[i]['id']]*result[i]['cost'] + ")";
        console.log("sql",sql)
        con.query(sql, function(error, resultQuery){
          if (error) throw error;
          console.log("1 order saved")
        })
      }
    })
  }

  async function sendingMail(data, result) {
    let res = '<h2>Order in Farbox</h2>';
    let total = 0;
    for (let i = 0; i < result.length; i++) {
      res += `Наименование ${result[i]['name']} - цена ${result[i]['cost']} - количество ${data.key[result[i]['id']]} - стоимость ${result[i]['cost']*data.key[result[i]['id']]}`;
      total += result[i]['cost']*data.key[result[i]['id']];
    }
    res += '<hr>'
    res += `Total ${total}`
    res += '<hr'
    res += `Phone: ${data.phone}`
    res += `name: ${data.username}`
    res += `Address: ${data.address}`
    res += `Email: ${data.email}`
    console.log('res', res)
    console.log('total', total)

  
  const nodemailer = require('nodemailer');

// Generate SMTP service account from ethereal.email
nodemailer.createTestAccount((err, account) => {
    if (err) {
        console.error('Failed to create a testing account. ' + err.message);
        return process.exit(1);
    }

    console.log('Credentials obtained, sending message...');

    // Create a SMTP transporter object
    let transporter = nodemailer.createTransport({
        host: account.smtp.host,
        port: account.smtp.port,
        secure: account.smtp.secure,
        auth: {
            user: account.user,
            pass: account.pass
        }
    });
    console.log(transporter)

    // Message object
    let message = {
        from: 'Sender Name <oleh.ovcz@gmail.com>',
        to: 'oleh.ovchynnikov@gmail.com',
        subject: 'Nodemailer is unicode friendly ✔',
        text: 'Hello to myself!',
        html: res
    };

    transporter.sendMail(message, (err, info) => {
        if (err) {
            console.log('Error occurred. ' + err.message);
            return process.exit(1);
        }

        console.log("Message sent: %s", info.messageId);
        // Preview only available when sending through an Ethereal account
        console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
    });
});

  }

  function makeHash(length) {
    let result = ''
    let chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqstuwxyz1234567890'
    let charLength = chars.length;
    for (let i = 0; i < length; i++) {
      result += chars.charAt(Math.floor(Math.random())*charLength)
    }
    console.log(result);
    return result;
  }