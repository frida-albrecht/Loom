module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-127> : tensor<10x10xi32>}> : () -> tensor<10x10xi32>
    %1 = "tosa.const"() <{values = dense<149> : tensor<1x10xi32>}> : () -> tensor<1x10xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<10x10xi32>, tensor<1x10xi32>) -> tensor<10x10xi32>
    %3 = tosa.const_shape  {values = dense<[1, 10, 1, 10]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %2, %3 : (tensor<10x10xi32>, !tosa.shape<4>) -> tensor<1x10x1x10xi32>
    %cast = tensor.cast %4 : tensor<1x10x1x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

