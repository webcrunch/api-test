module.exports = class Acl {

  // Here you can implement ACL
  // return true = allowed, false = forbidden

  // req.sesssion.user -> logged in user if any

  static checkRoute(req, table, method, isTable, isView) {
    
    // working with black listing so we default is everyone forbidden to use all the routes
    let role = req.session.user ? (req.session.user.userRole || "logged in") : 'not logged in'
    // console.log([' ---------------------', 'role:' + role, 'url:' + req.url, 'table:' + table, 'method:' + method,].join('\n'));
    //'isTable:' + isTable, 'isView:' + isView,
        
    // this route is open for not logged in  users and only for method post so they could logg in to the site
    if (role === 'not logged in' && table === 'users' && method === 'post') return true;

    // let all users get tales and views for the site. 
    if ( table === 'table:tables_and_views' &&  method === 'get') return true;
    
    // all logged in/admins could approach all get endpoints
    if (role === 'logged in' || 'Admin' && method === 'get') return true;

    // The roll as admin has the ability to do anything. 
    if (role === 'Admin') return true;

    // if (role === 'not logged in' && method !== 'get') return false;

    // if (role !== 'admin' && table === 'users') return false;

    return true;
  }
}