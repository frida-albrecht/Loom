module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.001000e+02> : tensor<7x1x8x2xf32>}> : () -> tensor<7x1x8x2xf32>
    %1 = "tosa.const"() <{values = dense<96> : tensor<2xi16>}> : () -> tensor<2xi16>
    %2 = tosa.exp %0 : (tensor<7x1x8x2xf32>) -> tensor<7x1x8x2xf32>
    %3 = tosa.clz %1 : (tensor<2xi16>) -> tensor<2xi16>
    %4 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<7x1x8x2xf32>) -> tensor<1x1x8x2xf32>
    %5 = tosa.bitwise_not %3 : (tensor<2xi16>) -> tensor<2xi16>
    %cast = tensor.cast %4 : tensor<1x1x8x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<2xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

