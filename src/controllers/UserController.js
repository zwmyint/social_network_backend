const User = require('../models/User');
const CreateUserService = require('../services/user/CreateUserService');

class UserController {
  
  constructor() {
    // this.createUserService = new CreateUserService();
    
  }
  
  async create(req, res, next) {
    let createUserService = new CreateUserService();
    await createUserService.create(req.body).then(result => {
      res.json(result)
    });

    next();
  }

}

module.exports = UserController;
