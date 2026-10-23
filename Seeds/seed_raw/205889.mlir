module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<84> : tensor<9x2x10xi32>}> : () -> tensor<9x2x10xi32>
    %1 = "tosa.const"() <{values = dense<-111> : tensor<9x2x10xi32>}> : () -> tensor<9x2x10xi32>
    %2 = tosa.minimum %0, %1 : (tensor<9x2x10xi32>, tensor<9x2x10xi32>) -> tensor<9x2x10xi32>
    %3 = tosa.const_shape  {values = dense<[1, 90, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.reshape %2, %3 : (tensor<9x2x10xi32>, !tosa.shape<3>) -> tensor<1x90x2xi32>
    %cast = tensor.cast %4 : tensor<1x90x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

