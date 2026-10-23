module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<160> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<36> : tensor<3x1x2x9xi16>}> : () -> tensor<3x1x2x9xi16>
    %2 = tosa.bitwise_not %0 : (tensor<i32>) -> tensor<i32>
    %3 = tosa.reduce_sum %1 {axis = 3 : i32} : (tensor<3x1x2x9xi16>) -> tensor<3x1x2x1xi16>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %3 : tensor<3x1x2x1xi16> to tensor<*xi16>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

