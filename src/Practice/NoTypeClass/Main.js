exports.equal = a => b => a === b;

exports.equalClass = () => a => b => a === b;

exports.equalRecord = Eq => a => b => Eq.eq(a)(b);
