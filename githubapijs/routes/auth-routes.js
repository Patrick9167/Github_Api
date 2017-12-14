const router = require('express').Router();

//auth login
router.get('/login', (req,res)=> {
  res.render('login');
});

//auth logout
router.get('/logout', (req,res)=> {
  res.send('logout');
});

router.get('/github', (req,res)=> {
  res.send('gub');
});

module.exports = router;
