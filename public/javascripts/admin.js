module.exports = function (req, res, con, next) {
    console.log('cookies', req.cookies);
    if (req.cookies.id === undefined || req.cookies.hash === undefined){
      res.redirect('/login');
      return false
    }
    con.query(
      'SELECT * FROM user WHERE id=' + req.cookies.id + ' and hash="' + req.cookies.hash +'"',
      function(error, result) {
        if(error) throw error;
        console.log(result);
        if (result.length === 0) {
          console.log("no auth");
          res.redirect('/login')
        } else {
          next();
        }
      }
    )
    // res.render('admin', {})
}