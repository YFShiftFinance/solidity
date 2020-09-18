pragma experimental SMTChecker;

contract C {
	uint t;
	constructor() {
		t = address(this).balance;
	}
	function f(address payable a, uint x) public {
		require(address(this).balance >= x);
		a.transfer(x);
	}
	function inv() public view {
		// If only looking at `f`, it looks like this.balance always decreases.
		// However, the edge case of a contract `selfdestruct` sending its remaining balance
		// to this contract should make the claim false.
		assert(address(this).balance <= t);
	}
}
// ----
// Warning 6328: (455-489): Assertion violation happens here.
// Warning 1236: (193-206): Insufficient funds happens here.
