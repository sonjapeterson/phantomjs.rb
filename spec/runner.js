console.log('bar');
var system = require('system');
for (var i = 1; i < system.args.length; i++) {
   console.log(system.args[i]);
}
phantom.exit();
