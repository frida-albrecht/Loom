module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-140> : tensor<16x8xi16>}> : () -> tensor<16x8xi16>
    %1 = "tosa.const"() <{values = dense<72> : tensor<8x32xi64>}> : () -> tensor<8x32xi64>
    %2 = "tosa.const"() <{values = dense<141> : tensor<16x32xi32>}> : () -> tensor<16x32xi32>
    %3 = linalg.matmul {cast = #linalg.type_fn<cast_unsigned>} ins(%0, %1 : tensor<16x8xi16>, tensor<8x32xi64>) outs(%2 : tensor<16x32xi32>) -> tensor<16x32xi32>
    %cast = tensor.cast %3 : tensor<16x32xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

