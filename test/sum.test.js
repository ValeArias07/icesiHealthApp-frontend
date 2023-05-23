const assert = require('assert');

describe('sum function', () => {
  it('should add two numbers correctly', () => {
    let result = 0;
    let number1= 3;
    let number2= 2;
    result = number1 + number2;
    assert.strictEqual(result, 5);
  });

  it('should multiply two numbers correctly', () => {
    let result = 0;
    let number1= 5;
    let number2= 2;
    result = number1 * number2;
    assert.strictEqual(result, 10);
  });
});
