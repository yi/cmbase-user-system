
mongoose = require('mongoose')
LocalStrategy = require('passport-local').Strategy
User = mongoose.model('User')


module.exports = (passport, config)->
  # require('./initializer')

  # serialize sessions
  passport.serializeUser (user, done)-> done(null, user.id)

  passport.deserializeUser (id, done)->
    User.findOne({ _id: id }, (err, user)-> done(err, user))

  # use local strategy
  localStrategyConfig =
    usernameField: 'email',
    passwordField: 'password'

  localStrategyCallback = (email, password, done)->
    User.findOne { email: email }, (err, user)->
      return done(err) if (err)
      return done(null, false, { message: 'Unknown user' }) unless user
      return done(null, false, { message: 'Invalid password' }) unless user.authenticate(password)
      return done(null, user)
    return

  passport.use new LocalStrategy localStrategyConfig, localStrategyCallback


