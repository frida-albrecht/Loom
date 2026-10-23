module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<109> : tensor<4x2x7xi16>}> : () -> tensor<4x2x7xi16>
    %1 = "tosa.const"() <{values = dense<6.665000e+01> : tensor<6x8xf32>}> : () -> tensor<6x8xf32>
    %2 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<4x2x7xi16>) -> tensor<1x2x7xi16>
    %3 = tosa.ceil %1 : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %4 = tosa.rsqrt %3 : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %cast = tensor.cast %2 : tensor<1x2x7xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %4 : tensor<6x8xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

