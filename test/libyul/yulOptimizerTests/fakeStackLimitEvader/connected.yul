{
	mstore(0x40, memoryguard(0))
	function g() -> a, b {
		a := 21
		let $c := 1
		b,a,$c := z()
	}
	function f() -> x {
		let $x2
		$x2 := 42
		let $x3, $x4 := g()
		x := mul(add($x2, $x3), h($x4))
		sstore($x3, $x4)
	}
	function h(v) -> a {
		let x, $z, y := z()
		a, $z, v := z()
	}
	function z() -> a,b,c { let $x := 0 }
	sstore(0, f())
	let x, y := g()
}
// ----
// step: fakeStackLimitEvader
//
// {
//     mstore(0x40, memoryguard(0xa0))
//     function g() -> a, b
//     {
//         a := 21
//         let $c_1 := 1
//         mstore(0x60, $c_1)
//         let b_2, a_4, $c_5 := z()
//         mstore(0x60, $c_5)
//         a := a_4
//         b := b_2
//     }
//     function f() -> x
//     {
//         let $x2_6 := 0
//         mstore(0x20, $x2_6)
//         let $x2_7 := 42
//         mstore(0x20, $x2_7)
//         let $x3_8, $x4_9 := g()
//         mstore(0x00, $x4_9)
//         mstore(0x40, $x3_8)
//         x := mul(add(mload(0x20), mload(0x40)), h(mload(0x00)))
//         sstore(mload(0x40), mload(0x00))
//     }
//     function h(v) -> a_1
//     {
//         let x_2_10, $z_11, y_12 := z()
//         mstore(0x60, $z_11)
//         let y := y_12
//         let x_2 := x_2_10
//         let a_1_13, $z_14, v_15 := z()
//         mstore(0x60, $z_14)
//         v := v_15
//         a_1 := a_1_13
//     }
//     function z() -> a_3, b_4, c
//     {
//         let $x_16 := 0
//         mstore(0x80, $x_16)
//     }
//     sstore(0, f())
//     let x_5, y_6 := g()
// }
