module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-150> : tensor<16x8xi16>}> : () -> tensor<16x8xi16>
    %1 = "tosa.const"() <{values = dense<0> : tensor<8x32xi64>}> : () -> tensor<8x32xi64>
    %2 = "tosa.const"() <{values = dense<-1.941500e+02> : tensor<16x32xf32>}> : () -> tensor<16x32xf32>
    %3 = linalg.matmul {cast = #linalg.type_fn<cast_unsigned>} ins(%0, %1 : tensor<16x8xi16>, tensor<8x32xi64>) outs(%2 : tensor<16x32xf32>) -> tensor<16x32xf32>
    %cast = tensor.cast %3 : tensor<16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

