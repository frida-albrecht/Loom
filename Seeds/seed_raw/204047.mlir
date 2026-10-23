module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-70> : tensor<4x9x5x9xi32>}> : () -> tensor<4x9x5x9xi32>
    %1 = "tosa.const"() <{values = dense<77> : tensor<72x9x5x9xi32>}> : () -> tensor<72x9x5x9xi32>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<4x9x5x9xi32>, tensor<72x9x5x9xi32>) -> tensor<76x9x5x9xi32>
    %3 = tosa.const_shape  {values = dense<[1, 9, 95, 36]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %2, %3 : (tensor<76x9x5x9xi32>, !tosa.shape<4>) -> tensor<1x9x95x36xi32>
    %5 = tosa.logical_right_shift %4, %4 : (tensor<1x9x95x36xi32>, tensor<1x9x95x36xi32>) -> tensor<1x9x95x36xi32>
    %cast = tensor.cast %5 : tensor<1x9x95x36xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

