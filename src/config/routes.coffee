
async = require "async"

module.exports = (app, passport, auth)->

  # user routes
  users = require "../controllers/users"
  app.get '/login', users.login
  app.get '/signup', users.signup
  app.get '/logout', users.logout
  app.post '/users', users.create
  app.post '/api/signup', ((req, res, next)-> (req.speak_as = "json") && next()), users.create

  app.post '/users/session', passport.authenticate('local', {failureRedirect: '/login', failureFlash: '无效的用户名或者密码.'}), users.session
  app.post '/api/login', passport.authenticate('local', { session: false }), (req, res)-> res.json({id:req.user.id, success:true})

  app.post '/api/change_password', passport.authenticate('local', { session: false }), ((req, res, next)-> (req.speak_as = "json") && next()), users.changePassword

  app.get '/users/:userId', users.show

  # this is home page
  home = require "../controllers/home"
  app.get '/', home.index
