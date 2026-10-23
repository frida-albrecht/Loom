module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<10x4xi16>}> : () -> tensor<10x4xi16>
    %1 = "tosa.const"() <{values = dense<43> : tensor<1x1xi16>}> : () -> tensor<1x1xi16>
    %2 = tosa.bitwise_or %0, %1 : (tensor<10x4xi16>, tensor<1x1xi16>) -> tensor<10x4xi16>
    // Fix for tosa.logical_right_shift: shift amount must be in range [0, 15] for i16.
    // Original shift amount is 43 (from %2), which is out of range.
    %c0 = "tosa.const"() <{values = dense<0> : tensor<10x4xi16>}> : () -> tensor<10x4xi16>
    %t1 = tosa.maximum %2, %c0 : (tensor<10x4xi16>, tensor<10x4xi16>) -> tensor<10x4xi16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<10x4xi16>}> : () -> tensor<10x4xi16>
    %t2 = tosa.minimum %t1, %c1 : (tensor<10x4xi16>, tensor<10x4xi16>) -> tensor<10x4xi16>
    %3 = tosa.logical_right_shift %2, %t2 : (tensor<10x4xi16>, tensor<10x4xi16>) -> tensor<10x4xi16>
    %4 = tosa.reduce_sum %3 {axis = 1 : i32} : (tensor<10x4xi16>) -> tensor<10x1xi16>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %7 = tosa.negate %4, %5, %6 : (tensor<10x1xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<10x1xi16>
    %8 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %9 = tosa.transpose %7 {perms = array<i32: 0, 1>} : (tensor<10x1xi16>) -> tensor<10x1xi16>
    %10 = tosa.logical_right_shift %9, %9 : (tensor<10x1xi16>, tensor<10x1xi16>) -> tensor<10x1xi16>
    %11 = tosa.bitwise_not %10 : (tensor<10x1xi16>) -> tensor<10x1xi16>
    %cast = tensor.cast %11 : tensor<10x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}