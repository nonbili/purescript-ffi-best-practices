exports.fetchPromise_ = id => () =>
  new Promise((resolve, reject) => {
    if (id < 1) {
      reject("Invalid id");
    }
    resolve(`Promise content of ${id}`);
  });

exports.fetchAsync_ = id =>
  async function() {
    return await exports.fetchPromise_(id)();
  };
