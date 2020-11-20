const express = require('express');
const routes = express.Router();

const bcrypt = require('bcrypt');

//models:
const User = require('./models/User');
//services
const UserController = require('./controllers/UserController');

//create user
const userController = new UserController();
routes.post('/user/create', userController.create);

module.exports = routes;
