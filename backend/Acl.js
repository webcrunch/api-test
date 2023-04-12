module.exports = class Acl {

  // Here you can implement ACL
  // return true = allowed, false = forbidden

  // req.sesssion.user -> logged in user if any

  static checkRoute(req, table, method, isTable, isView) {
    let role = req.session.user ? (req.session.user.userRole || "logged in") : 'not logged in'
    console.log(['role:' + role, 'url:' + req.url, 'table:' + table, 'method:' + method,].join('\n'));
    //'isTable:' + isTable, 'isView:' + isView,
        
    if (role === 'not logged in' && table === 'users' && method === 'post') return true;

    if (role === 'not logged in' && method !== 'get') return false;

    if (role !== 'admin' && table === 'users') return false;

    return true;
  }
}