exports.simpleObject = {
  x: 1,
  y: "2",
  z: true
};

exports.nullableObject = {
  x: null
};

exports.nullableObject_ = {
  x: null
};

exports.encodeSimple = obj => JSON.stringify(obj);

exports.encodeNullable_ = obj => JSON.stringify(obj);

exports.getKeys_ = assocs => {
  const set = new Set();
  assocs.forEach(assoc => assoc[0].forEach(x => set.add(x)));
  return Array.from(set);
};
