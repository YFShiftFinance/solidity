{
	mstore(0x40, memoryguard(0))
	function f() {
	    let $fx
	    let $fy := 42
	    sstore($fx, $fy)
	    $fx := 21
	}
	function g(gx) {
	    let $gx, $gy := tuple2()
	    { $gx, $gy := tuple2() }
	    { $gx, gx := tuple2() }
	    { gx, $gy := tuple2() }
	}
	function h(hx, hy, hz, hw) {
	    let $hx, $hy, $hz, $hw := tuple4()
	    { hx, $hy, hz, $hw := tuple4() }
	    { $hx, $hy, hz, hw := tuple4() }
	}
	function tuple2() -> a, b {}
	function tuple4() -> a, b, c, d {}
    f()
    g(0)
    h(1, 2, 3, 4)
}
// ----
// step: fakeStackLimitEvader
//
// {
//     mstore(0x40, memoryguard(0x80))
//     function f()
//     {
//         let $fx_1 := 0
//         mstore(0x40, $fx_1)
//         let $fy_2 := 42
//         mstore(0x60, $fy_2)
//         sstore(mload(0x40), mload(0x60))
//         let $fx_3 := 21
//         mstore(0x40, $fx_3)
//     }
//     function g(gx)
//     {
//         let $gx_4, $gy_5 := tuple2()
//         mstore(0x40, $gy_5)
//         mstore(0x60, $gx_4)
//         {
//             let $gx_6, $gy_7 := tuple2()
//             mstore(0x40, $gy_7)
//             mstore(0x60, $gx_6)
//         }
//         {
//             let $gx_8, gx_9 := tuple2()
//             mstore(0x60, $gx_8)
//             gx := gx_9
//         }
//         {
//             let gx_10, $gy_11 := tuple2()
//             mstore(0x40, $gy_11)
//             gx := gx_10
//         }
//     }
//     function h(hx, hy, hz, hw)
//     {
//         let $hx_12, $hy_13, $hz_14, $hw_15 := tuple4()
//         mstore(0x00, $hw_15)
//         mstore(0x60, $hz_14)
//         mstore(0x40, $hy_13)
//         mstore(0x20, $hx_12)
//         {
//             let hx_16, $hy_17, hz_18, $hw_19 := tuple4()
//             mstore(0x00, $hw_19)
//             mstore(0x40, $hy_17)
//             hz := hz_18
//             hx := hx_16
//         }
//         {
//             let $hx_20, $hy_21, hz_22, hw_23 := tuple4()
//             mstore(0x40, $hy_21)
//             mstore(0x20, $hx_20)
//             hw := hw_23
//             hz := hz_22
//         }
//     }
//     function tuple2() -> a, b
//     { }
//     function tuple4() -> a_1, b_2, c, d
//     { }
//     f()
//     g(0)
//     h(1, 2, 3, 4)
// }
