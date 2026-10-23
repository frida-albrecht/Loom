module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<181> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<-122> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<1.588900e+02> : tensor<7x7x5x1xf32>}> : () -> tensor<7x7x5x1xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %4 = tosa.rsqrt %2 : (tensor<7x7x5x1xf32>) -> tensor<7x7x5x1xf32>
    %5 = tosa.floor %4 : (tensor<7x7x5x1xf32>) -> tensor<7x7x5x1xf32>
    %cast = tensor.cast %3 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<7x7x5x1xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

