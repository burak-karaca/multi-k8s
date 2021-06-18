// required for connecting to redis db
const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  // if it ever loses connection to redis server, it will try to connect once in 1ms
  retry_strategy: () => 1000
});

const sub = redisClient.duplicate();
// function for calculating Fibonacci values
function fib(index) {
  if (index < 2) return 1;
  return fib(index - 1) + fib(index - 2);
}
// any time we get a new value from redis, the new fib value will be calculated and insert to redis instance
sub.on('message', (channel, message) => {
  redisClient.hset('values', message, fib(parseInt(message)));
});
sub.subscribe('insert');
