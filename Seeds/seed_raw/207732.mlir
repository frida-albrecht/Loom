module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-19> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = tosa.const_shape  {values = dense<8> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.reshape %0, %1 : (tensor<8xi32>, !tosa.shape<1>) -> tensor<8xi32>
    %cast = tensor.cast %2 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

