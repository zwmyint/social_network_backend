const User = require('../../models/User');

const pool = require('../../database/connection');

class CreateUserService {
  
  async create(newUser) {
    //Nova instância 
    let user = new User(newUser);

    //verifica existência de nome de usuário e email
    let sql = "SELECT CASE WHEN email = $1 AND username = $2 THEN 'email e username já existem.' WHEN email = $1 THEN 'email já existe.' WHEN username = $2 THEN 'username ja existe.' end already_exists FROM customer WHERE email = $1 OR username = $2 LIMIT 1;";
    let values = [newUser.email, newUser.username];

    let buscaUsuário = await pool.query(sql, values);

    if(buscaUsuário.rows.length > 0) {
      let response = {msg: buscaUsuário.rows[0].already_exists, code: 409};
      return response;
    }
    
    await user.setPassword(newUser.password);

    sql = "INSERT INTO customer(email, username, first_name, last_name, password) VALUES($1, $2, $3, $4, $5);";
    const {email, username, firstName, lastName, password} = user;
    values = [email, username, firstName, lastName, password]
    
    await pool.query(sql, values);

    let response = {msg: 'Usuário criado.', code: 201}
    return response;    
  }
}

module.exports = CreateUserService;
