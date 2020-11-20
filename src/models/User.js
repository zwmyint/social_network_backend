const bcrypt = require('bcrypt');

class User {
  password;
  
  constructor(user){
    this.id = user.id;
    this.email = user.email;
    this.username = user.username;
    this.firstName = user.firstName;
    this.lastName = user.lastName;
    this.createdAt = user.createdAt;
    this.updatedAt = user.updatedAt;
  }

  async setPassword(rawPassword) {
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(rawPassword, salt);
    this.password = hash;
  }
}

module.exports = User;
