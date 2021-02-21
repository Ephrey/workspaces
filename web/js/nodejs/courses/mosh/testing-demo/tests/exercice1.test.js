const leb = require("../exercise1");

describe("fizzBuzz", () => {
  it("should throw if input is not a valid number", () => {
    expect(() => leb.fizzBuzz("")).toThrow();
    expect(() => leb.fizzBuzz(null)).toThrow();
    expect(() => leb.fizzBuzz(false)).toThrow();
    expect(() => leb.fizzBuzz(undefined)).toThrow();
    expect(() => leb.fizzBuzz({})).toThrow();
  });

  it("should return FizzBuzz if the input is devisable by 3 and 5", () => {
    const result = leb.fizzBuzz(15);
    expect(result).toBe("FizzBuzz");
  });

  it("should return Fizz if input devisable by 3", () => {
    const result = leb.fizzBuzz(9);
    expect(result).toBe("Fizz");
  });

  it("should return Buzz if input devisable by 5", () => {
    const result = leb.fizzBuzz(25);
    expect(result).toBe("Buzz");
  });

  it("should return the input if number not devisable by 3, 5 and both 3 and 5 ", () => {
    const result = leb.fizzBuzz(7);
    expect(result).toBe(7);
  });
});
