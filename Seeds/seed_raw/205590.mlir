module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<10x4xi16>}> : () -> tensor<10x4xi16>
    %1 = "tosa.const"() <{values = dense<43> : tensor<1x1xi16>}> : () -> tensor<1x1xi16>
    %2 = tosa.bitwise_or %0, %1 : (tensor<10x4xi16>, tensor<1x1xi16>) -> tensor<10x4xi16>
    %3 = tosa.logical_right_shift %2, %2 : (tensor<10x4xi16>, tensor<10x4xi16>) -> tensor<10x4xi16>
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

