module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.501000e+01> : tensor<2x6x6x10xf32>}> : () -> tensor<2x6x6x10xf32>
    %1 = "tosa.const"() <{values = dense<148> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<-133> : tensor<i16>}> : () -> tensor<i16>
    %3 = tosa.floor %0 : (tensor<2x6x6x10xf32>) -> tensor<2x6x6x10xf32>
    %4 = tosa.log %3 : (tensor<2x6x6x10xf32>) -> tensor<2x6x6x10xf32>
    %5 = tosa.bitwise_or %1, %2 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %6 = tosa.arithmetic_right_shift %5, %5 {round = true} : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %7 = tosa.reciprocal %3 : (tensor<2x6x6x10xf32>) -> tensor<2x6x6x10xf32>
    %cast = tensor.cast %4 : tensor<2x6x6x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<i16> to tensor<*xi16>
    %cast_1 = tensor.cast %7 : tensor<2x6x6x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

