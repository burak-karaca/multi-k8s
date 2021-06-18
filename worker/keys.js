// any time we want to connect to Redis, we will use these env variable names to connect
module.exports = {
  redisHost: process.env.REDIS_HOST,
  redisPort: process.env.REDIS_PORT
};
