
# Module dependencies.

mongoose = require('mongoose')
User = mongoose.model('User')

exports.signin = (req, res)->

# Auth callback
exports.authCallback = (req, res, next)->
  res.redirect('/')
  return

# Show login form
exports.login = (req, res)->
  res.render 'users/login',
    title: 'Login',
    message: req.flash('error')
  return

# Show sign up form
exports.signup = (req, res)->
  res.render 'users/signup',
    title: 'Sign up',
    user: new User()
  return

# Logout
exports.logout = (req, res)->
  req.logout()
  res.redirect('/login')
  return

# Session
exports.session = (req, res)->
  res.redirect('/')
  return

# Create user
exports.create = (req, res, next)->

  console.log "[users::create] req.speak_as:#{req.speak_as}"

  newUser = new User(req.body)
  newUser.provider = 'local'

  User.findOne({ username: newUser.username}).exec (err, user)->
    return next(err) if err?
    unless user?
      newUser.save (err)->
        if err?
          if req.speak_as is "json"
            next(new EvalError(String(err)))
            #res.json
              #error: String(err)
              #success: false
          else
            res.render 'users/signup',
              errors: err.errors
              user:newUser
          return

        req.logIn newUser, (err)->
          return next err if err?

          if req.speak_as is "json"
            res.json
              id : newUser.id
              success: true
          else
            return res.redirect('/')

        return
    else
      if req.speak_as is "json"
        next(new EvalError("用户名已存在"))
        #res.json
          #error: "用户名已存在"
          #success: false
      else
        res.render 'users/signup',
          errors: [{"type":"username already registered"}]
          user:newUser
      return
    return
  return

exports.changePassword = (req, res, next)->

  return next(new EvalError("missing user")) unless req.user?

  newPassword = String(req.body.new_password || "").trim()

  unless newPassword
    return next(new EvalError("无效的新密码，请重新选择密码"))

  req.user.set('password', newPassword)
  #req.user.isNew = true

  req.user.save (err)->
    return next(err) if err?
    res.json
      id : req.user.id
      success: true
    return

  return


#  Show profile
exports.show = (req, res)->
  User.findOne({ _id : req.params['userId'] }).exec (err, user)->
    return next(err) if err?
    return next(new Error('Failed to load User ' + id)) unless user?

    res.render 'users/show',
      title: user.name,
      user: user
    return
  return

# Find user by id
exports.user = (req, res, next, id)->
  User.findOne({ _id : id }).exec (err, user)->
    return next(err) if err?
    return next(new Error('Failed to load User ' + id)) unless user?
    req.profile = user
    next()
    return
  return



