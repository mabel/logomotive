var passport = require('passport')
  , Strategy = require('passport-local').Strategy;

module.exports = function() {

  passport.use(new Strategy({}, function(user, password, done) {
     return done(null, true);
  }));
  this.passport = passport
}