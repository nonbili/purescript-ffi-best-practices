exports.equal_ = function(a, b) {
  return a === b;
};

exports.equalEffect_ = function(a, b) {
  return a === b;
};

exports.equal = a => b => a === b;

exports.equalEffect = a => b => () => a === b;
