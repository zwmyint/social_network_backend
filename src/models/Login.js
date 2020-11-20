class Login {
  constructor(username, password){
    this.username = username;
    this.password = hashPassword(password);
  }

  async hashPassword(password) {
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(password, salt);
    
    return hash;
  }

  async login() {

  }
}
