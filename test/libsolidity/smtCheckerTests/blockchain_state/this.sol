pragma experimental SMTChecker;

contract C {
	address t;
	constructor() {
		t = address(this);
	}
	function inv() public view {
		assert(address(this) == t);
	}
}
// ----
// Warning 6328: (131-157): Assertion violation happens here.
