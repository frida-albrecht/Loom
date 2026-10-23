module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.693750e+01> : tensor<16x8xf16>}> : () -> tensor<16x8xf16>
    %1 = "tosa.const"() <{values = dense<-1.133700e+02> : tensor<8x32xf64>}> : () -> tensor<8x32xf64>
    %2 = "tosa.const"() <{values = dense<22> : tensor<16x32xi32>}> : () -> tensor<16x32xi32>
    %3 = linalg.matmul {cast = #linalg.type_fn<cast_unsigned>} ins(%0, %1 : tensor<16x8xf16>, tensor<8x32xf64>) outs(%2 : tensor<16x32xi32>) -> tensor<16x32xi32>
    %cast = tensor.cast %3 : tensor<16x32xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

